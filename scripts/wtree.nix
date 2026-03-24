{ pkgs ? import <nixpkgs> {} }:

pkgs.writeShellApplication {
  name = "wtree";

  runtimeInputs = with pkgs; [
    bash
    git
    fd
    jq
    tmux
    coreutils
    findutils
    util-linux
  ];

  text = ''
    COMMAND="create"
    BRANCH=""
    BASE="main"
    USE_EXISTING=false
    FORCE=false
    MULTIPLEXER=""

    print_usage() {
      cat <<'HELP'
    uso: wtree <branch> [opcoes]            # cria worktree + sessao no multiplexer
         wtree --rm <branch> [-f]           # remove worktree, branch e sessao

    Cria um git worktree em ~/code/worktrees/<repo>-<branch>, copia
    qualquer .env* (.envrc, .env, .env.local, .env.production, .env.staging,
    etc.), roda direnv allow + pnpm install e abre sessao no multiplexer
    com a tab AI ja rodando claude.

    Deteccao de multiplexer (auto, nesta ordem):
      herdr (HERDR_ENV=1)        -> workspace agrupado ao repo pai (tab code
                                    com split + tab AI rodando claude)
      cmux  (CMUX_WORKSPACE_ID)  -> novo workspace cmux rodando claude
      tmux  ($TMUX)              -> sessao tmux (janela code split + janela AI)
      zellij ($ZELLIJ)           -> sessao zellij com layout wtree
      caso contrario             -> tmux

    Modo create (default):
      --base <branch>   Branch base ao criar nova (default: main)
      --existing        Usar branch ja existente em vez de criar

    Modo remove:
      --rm              Ativa modo de remocao
      -f, --force       Forca git worktree remove -f e git branch -D

    Outros:
      --herdr           Forca uso de herdr (override do auto-detect)
      --cmux            Forca uso de cmux (override do auto-detect)
      --tmux            Forca uso de tmux (override do auto-detect)
      --zellij          Forca uso de zellij (override do auto-detect)
      -h, --help        Mostra este help
    HELP
    }

    while [[ $# -gt 0 ]]; do
      case "$1" in
        --rm)
          COMMAND="remove"
          shift
          ;;
        --base)
          BASE="''${2:-}"
          if [[ -z "$BASE" ]]; then
            echo "wtree: --base requer valor" >&2
            exit 2
          fi
          shift 2
          ;;
        --existing)
          USE_EXISTING=true
          shift
          ;;
        -f|--force)
          FORCE=true
          shift
          ;;
        --herdr|--cmux|--tmux|--zellij)
          want="''${1#--}"
          if [[ -n "$MULTIPLEXER" && "$MULTIPLEXER" != "$want" ]]; then
            echo "wtree: --$want conflita com --$MULTIPLEXER" >&2
            exit 2
          fi
          MULTIPLEXER="$want"
          shift
          ;;
        -h|--help)
          print_usage
          exit 0
          ;;
        --*)
          echo "wtree: flag desconhecida: $1" >&2
          exit 2
          ;;
        *)
          if [[ -z "$BRANCH" ]]; then
            BRANCH="$1"
          else
            echo "wtree: argumento extra: $1" >&2
            exit 2
          fi
          shift
          ;;
      esac
    done

    if [[ -z "$BRANCH" ]]; then
      print_usage >&2
      exit 2
    fi

    if ! SOURCE_ROOT=$(git rev-parse --show-toplevel 2>/dev/null); then
      echo "wtree: nao esta em um git repo" >&2
      exit 2
    fi

    # Raiz do repo principal (primeira entrada do worktree list). Usar isso
    # em vez de SOURCE_ROOT garante naming e operacoes git corretas mesmo
    # rodando de dentro de um worktree (senao o nome/path saem duplicados).
    MAIN_ROOT=$(git -C "$SOURCE_ROOT" worktree list --porcelain 2>/dev/null \
      | awk '/^worktree /{print substr($0, 10); exit}' || true)
    if [[ -z "$MAIN_ROOT" ]]; then
      MAIN_ROOT="$SOURCE_ROOT"
    fi

    if [[ -z "$MULTIPLEXER" ]]; then
      if [[ "''${HERDR_ENV:-}" == "1" ]]; then
        MULTIPLEXER="herdr"
      elif [[ -n "''${CMUX_WORKSPACE_ID:-}" ]]; then
        MULTIPLEXER="cmux"
      elif [[ -n "''${TMUX:-}" ]]; then
        MULTIPLEXER="tmux"
      elif [[ -n "''${ZELLIJ:-}" ]]; then
        MULTIPLEXER="zellij"
      else
        MULTIPLEXER="tmux"
      fi
    fi

    REPO_NAME=$(basename "$MAIN_ROOT")
    SAFE_BRANCH="''${BRANCH//\//-}"
    WORKTREE_BASE="$HOME/code/worktrees"
    WORKTREE_DIR="$WORKTREE_BASE/''${REPO_NAME}-''${SAFE_BRANCH}"
    SESSION_NAME="''${REPO_NAME}-''${SAFE_BRANCH}"

    if [[ "$COMMAND" == "remove" ]]; then
      # Se estiver rodando de dentro do worktree alvo, sai dele primeiro:
      # o git roda via -C "$MAIN_ROOT", entao a remocao funciona mesmo assim.
      if [[ "$SOURCE_ROOT" == "$WORKTREE_DIR" ]]; then
        echo "==> rodando de dentro do worktree alvo; movendo cwd p/ $MAIN_ROOT"
        cd "$MAIN_ROOT"
      fi

      if command -v herdr >/dev/null 2>&1; then
        echo "==> herdr: fechando workspace '$SESSION_NAME' (se existir)"
        ws_id=$(herdr workspace list 2>/dev/null \
          | jq -r --arg n "$SESSION_NAME" \
            '.result.workspaces[]? | select(.label == $n) | .workspace_id' 2>/dev/null \
          | head -n1 || true)
        if [[ -n "$ws_id" ]]; then
          herdr workspace close "$ws_id" >/dev/null 2>&1 || true
        fi
      fi

      if command -v cmux >/dev/null 2>&1; then
        echo "==> cmux: fechando workspace '$SESSION_NAME' (se existir)"
        ws_ref=$(cmux list-workspaces 2>/dev/null \
          | sed 's/^\* //' \
          | awk -v n="$SESSION_NAME" '$2 == n { print $1; exit }' || true)
        if [[ -n "$ws_ref" ]]; then
          cmux close-workspace --workspace "$ws_ref" >/dev/null 2>&1 || true
        fi
      fi

      echo "==> kill sessao tmux '$SESSION_NAME' (se existir)"
      tmux kill-session -t "$SESSION_NAME" >/dev/null 2>&1 || true

      echo "==> kill + delete sessao zellij '$SESSION_NAME'"
      zellij kill-session "$SESSION_NAME" >/dev/null 2>&1 || true
      zellij delete-session "$SESSION_NAME" >/dev/null 2>&1 || true

      if [[ -d "$WORKTREE_DIR" ]]; then
        echo "==> git worktree remove $WORKTREE_DIR"
        if $FORCE; then
          git -C "$MAIN_ROOT" worktree remove -f "$WORKTREE_DIR"
        elif git -C "$MAIN_ROOT" worktree remove "$WORKTREE_DIR" 2>/dev/null; then
          : # removido limpo
        else
          # falhou: provavelmente por arquivos nao-versionados que o proprio
          # wtree criou (.env*, node_modules, .direnv). So forca se NAO houver
          # alteracoes em arquivos versionados (trabalho real nao commitado).
          dirty_tracked=$(git -C "$WORKTREE_DIR" status --porcelain --untracked-files=no 2>/dev/null || true)
          if [[ -z "$dirty_tracked" ]]; then
            echo "    (so arquivos nao-versionados; forcando remocao)"
            git -C "$MAIN_ROOT" worktree remove -f "$WORKTREE_DIR"
          else
            echo "wtree: worktree tem alteracoes nao commitadas em arquivos versionados:" >&2
            echo "$dirty_tracked" >&2
            echo "    use -f para forcar (descarta as alteracoes)" >&2
            exit 1
          fi
        fi
      else
        echo "==> worktree nao existe em $WORKTREE_DIR (skip)"
      fi

      # limpa metadados de worktrees ja apagados manualmente
      git -C "$MAIN_ROOT" worktree prune >/dev/null 2>&1 || true

      if $FORCE; then
        echo "==> git branch -D $BRANCH"
        if ! err=$(git -C "$MAIN_ROOT" branch -D "$BRANCH" 2>&1); then
          echo "    (branch nao existia: $err)"
        fi
      else
        echo "==> git branch -d $BRANCH"
        if ! err=$(git -C "$MAIN_ROOT" branch -d "$BRANCH" 2>&1); then
          echo "wtree: branch nao removida:" >&2
          echo "    $err" >&2
          echo "    use -f para forcar (git branch -D)" >&2
          exit 1
        fi
      fi

      echo "==> pronto. worktree, branch e sessao (herdr/cmux/tmux/zellij) removidos"
      exit 0
    fi

    if [[ -e "$WORKTREE_DIR" ]]; then
      echo "wtree: $WORKTREE_DIR ja existe" >&2
      exit 1
    fi

    mkdir -p "$WORKTREE_BASE"

    echo "==> git worktree add $WORKTREE_DIR"
    if $USE_EXISTING; then
      git -C "$MAIN_ROOT" worktree add "$WORKTREE_DIR" "$BRANCH"
    else
      git -C "$MAIN_ROOT" worktree add -b "$BRANCH" "$WORKTREE_DIR" "$BASE"
    fi

    echo "==> copiando .env*"
    copied=0
    while IFS= read -r -d "" envfile; do
      rel="''${envfile#"$SOURCE_ROOT"/}"
      dest="$WORKTREE_DIR/$rel"
      mkdir -p "$(dirname "$dest")"
      cp "$envfile" "$dest"
      echo "    $rel"
      copied=$((copied + 1))
    done < <(fd -H -I -t f \
      -E node_modules -E .git -E .next -E .direnv -E .nx -E .turbo -E .cache -E dist -E build \
      '^\.env' "$SOURCE_ROOT" --print0)
    if [[ $copied -eq 0 ]]; then
      echo "    (nenhum arquivo encontrado)"
    fi

    if command -v direnv >/dev/null 2>&1 && [[ -f "$WORKTREE_DIR/.envrc" ]]; then
      echo "==> direnv allow"
      (cd "$WORKTREE_DIR" && direnv allow)
    fi

    if command -v pnpm >/dev/null 2>&1 && [[ -f "$WORKTREE_DIR/package.json" ]]; then
      echo "==> pnpm install"
      (cd "$WORKTREE_DIR" && pnpm install)
    fi

    cd "$WORKTREE_DIR"

    if [[ "$MULTIPLEXER" == "herdr" ]]; then
      if ! command -v herdr >/dev/null 2>&1; then
        echo "wtree: herdr nao esta no PATH" >&2
        exit 1
      fi
      echo "==> abrindo herdr workspace $SESSION_NAME"

      # worktree open agrupa o checkout (ja criado pelo git acima) como
      # workspace filho do repo pai ($SOURCE_ROOT) na sidebar do herdr.
      RESP=$(herdr worktree open --cwd "$MAIN_ROOT" --path "$WORKTREE_DIR" \
        --label "$SESSION_NAME" --no-focus --json 2>&1 || true)
      WS_ID=$(jq -r '.result.workspace.workspace_id // empty' <<<"$RESP" 2>/dev/null || true)
      TAB_ID=$(jq -r '.result.tab.tab_id // empty' <<<"$RESP" 2>/dev/null || true)
      ROOT_PANE=$(jq -r '.result.root_pane.pane_id // empty' <<<"$RESP" 2>/dev/null || true)

      if [[ -z "$WS_ID" || -z "$TAB_ID" || -z "$ROOT_PANE" ]]; then
        echo "wtree: resposta inesperada do herdr worktree open:" >&2
        echo "    $RESP" >&2
        exit 1
      fi

      herdr tab rename "$TAB_ID" "code" >/dev/null
      herdr pane split "$ROOT_PANE" --direction right --no-focus >/dev/null

      AI_RESP=$(herdr tab create --workspace "$WS_ID" --cwd "$WORKTREE_DIR" \
        --label "AI" --no-focus)
      AI_TAB=$(jq -r '.result.tab.tab_id // empty' <<<"$AI_RESP" 2>/dev/null || true)
      AI_PANE=$(jq -r '.result.root_pane.pane_id // empty' <<<"$AI_RESP" 2>/dev/null || true)
      if [[ -n "$AI_PANE" ]]; then
        herdr pane run "$AI_PANE" "claude"
      fi

      herdr workspace focus "$WS_ID" >/dev/null
      if [[ -n "$AI_TAB" ]]; then
        herdr tab focus "$AI_TAB" >/dev/null
      fi
      exit 0
    elif [[ "$MULTIPLEXER" == "cmux" ]]; then
      if ! command -v cmux >/dev/null 2>&1; then
        echo "wtree: cmux nao esta no PATH" >&2
        exit 1
      fi
      echo "==> cmux: novo workspace '$SESSION_NAME' rodando claude"
      ws_out=$(cmux new-workspace --cwd "$WORKTREE_DIR" --command "claude" 2>&1 || true)
      ws_ref=$(printf '%s\n' "$ws_out" | awk '/^OK / { print $2; exit }')
      if [[ -n "$ws_ref" ]]; then
        cmux rename-workspace --workspace "$ws_ref" "$SESSION_NAME" >/dev/null 2>&1 || true
        cmux select-workspace --workspace "$ws_ref" >/dev/null 2>&1 || true
      else
        echo "wtree: cmux new-workspace falhou: $ws_out" >&2
        exit 1
      fi
      exit 0
    elif [[ "$MULTIPLEXER" == "tmux" ]]; then
      if ! command -v tmux >/dev/null 2>&1; then
        echo "wtree: tmux nao esta no PATH" >&2
        exit 1
      fi
      echo "==> abrindo tmux sessao $SESSION_NAME"

      if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
        echo "wtree: sessao tmux '$SESSION_NAME' ja existe — anexando"
      else
        tmux new-session -d -s "$SESSION_NAME" -n "code" -c "$WORKTREE_DIR"
        tmux split-window -h -t "$SESSION_NAME:code" -c "$WORKTREE_DIR"
        tmux select-pane -t "$SESSION_NAME:code.1"

        tmux new-window -t "$SESSION_NAME" -n "AI" -c "$WORKTREE_DIR" "zsh -ic claude"
        tmux select-window -t "$SESSION_NAME:AI"
      fi

      if [[ -n "''${TMUX:-}" ]]; then
        tmux switch-client -t "$SESSION_NAME"
      else
        exec tmux attach -t "$SESSION_NAME"
      fi
    else
      LAYOUT_FILE="$HOME/.config/zellij/layouts/wtree.kdl"
      if [[ ! -f "$LAYOUT_FILE" ]]; then
        echo "wtree: layout nao encontrado em $LAYOUT_FILE" >&2
        echo "wtree: rebuilde o sistema (nixos-rebuild switch) para gerar." >&2
        exit 1
      fi

      echo "==> abrindo zellij sessao $SESSION_NAME"

      if [[ -n "''${ZELLIJ:-}" ]]; then
        # zellij precisa de TTY: usa script(1) como pty falso e setsid pra
        # destacar do terminal atual. A sessao roda detached em background
        # ate o switch-session abaixo "puxar" o cliente pra ela.
        # PTY generoso (300x100) pra sessao nao iniciar pequena. zellij
        # reajusta pro tamanho real do terminal externo automaticamente
        # quando o client conecta via switch-session.
        setsid -f script -qfec \
          "stty rows 100 cols 300; zellij --session '$SESSION_NAME' --new-session-with-layout '$LAYOUT_FILE'" \
          /dev/null </dev/null >/dev/null 2>&1 || true

        # esperar a sessao aparecer no list-sessions (max ~3s)
        for _ in $(seq 1 30); do
          if zellij list-sessions -s 2>/dev/null | grep -qx "$SESSION_NAME"; then
            break
          fi
          sleep 0.1
        done

        echo "==> switch-session $SESSION_NAME"
        zellij action switch-session "$SESSION_NAME"
      else
        exec zellij --session "$SESSION_NAME" --new-session-with-layout "$LAYOUT_FILE"
      fi
    fi
  '';
}
