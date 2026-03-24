{ pkgs ? import <nixpkgs> {} }:

pkgs.writeShellApplication {
  name = "cc-review";

  runtimeInputs = with pkgs; [
    bash
    git
    gh
    jq
    coreutils
  ];

  text = ''
    print_usage() {
      cat >&2 <<'EOF'
uso:
  cc-review <PR_NUMBER>                       # detecta owner/repo do remote origin
  cc-review <owner/repo> <PR_NUMBER>          # slug + numero
  cc-review <url-do-PR>                       # URL completa
EOF
    }

    if [ $# -lt 1 ] || [ $# -gt 2 ]; then
      print_usage
      exit 2
    fi

    REPO_SLUG=""
    PR_NUMBER=""

    if [ $# -eq 2 ]; then
      REPO_SLUG="$1"
      PR_NUMBER="$2"
    else
      ARG="$1"
      if [[ "$ARG" =~ ^https?://github\.com/([^/]+/[^/]+)/pull/([0-9]+)(/.*)?$ ]]; then
        REPO_SLUG="''${BASH_REMATCH[1]}"
        PR_NUMBER="''${BASH_REMATCH[2]}"
      elif [[ "$ARG" =~ ^[0-9]+$ ]]; then
        PR_NUMBER="$ARG"
        if ! REMOTE_URL=$(git config --get remote.origin.url 2>/dev/null); then
          echo "cc-review: nao esta em um git repo (passe owner/repo ou URL)" >&2
          exit 2
        fi
        REPO_SLUG=$(echo "$REMOTE_URL" \
          | sed -E 's#^(git@github\.com:|https://github\.com/)##; s#\.git$##')
      else
        echo "cc-review: argumento invalido: $ARG" >&2
        print_usage
        exit 2
      fi
    fi

    if [[ ! "$PR_NUMBER" =~ ^[0-9]+$ ]]; then
      echo "cc-review: PR_NUMBER deve ser numerico (got: $PR_NUMBER)" >&2
      exit 2
    fi

    if [[ ! "$REPO_SLUG" =~ ^[^/]+/[^/]+$ ]]; then
      echo "cc-review: owner/repo invalido (got: $REPO_SLUG)" >&2
      exit 2
    fi

    REPO_NAME="''${REPO_SLUG##*/}"
    PR_URL="https://github.com/''${REPO_SLUG}/pull/''${PR_NUMBER}"

    # Verifica se o PR existe antes de gastar a chamada do claude.
    # Captura stderr para distinguir "nao encontrado" de erro de auth/rede.
    if ! GH_OUT=$(gh pr view "$PR_NUMBER" --repo "$REPO_SLUG" --json title,state 2>&1); then
      echo "cc-review: nao foi possivel acessar PR #$PR_NUMBER em $REPO_SLUG" >&2
      echo "  $GH_OUT" >&2
      exit 2
    fi
    PR_TITLE=$(echo "$GH_OUT" | jq -r .title)
    PR_STATE=$(echo "$GH_OUT" | jq -r .state)

    OUTPUT_DIR="$HOME/code/reviews"
    mkdir -p "$OUTPUT_DIR"
    OUTPUT="$OUTPUT_DIR/''${REPO_NAME}-''${PR_NUMBER}.md"

    echo "==> PR #$PR_NUMBER [$PR_STATE]: $PR_TITLE"
    echo "==> review: $PR_URL"
    echo "==> output: $OUTPUT"

    claude --print "/review $PR_URL" | tee "$OUTPUT"

    if [ -n "''${CMUX_WORKSPACE_ID:-}" ] && command -v cmux >/dev/null 2>&1; then
      echo "==> cmux markdown $OUTPUT"
      cmux markdown "$OUTPUT" || true
    fi
  '';
}
