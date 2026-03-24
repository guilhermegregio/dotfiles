{ pkgs ? import <nixpkgs> {} }:

let
  platformInputs = pkgs.lib.optionals pkgs.stdenv.isLinux [ pkgs.libnotify ];
in
pkgs.writeShellApplication {
  name = "notify-beep";

  excludeShellChecks = [ "SC1003" ];

  runtimeInputs = with pkgs; [
    bash
    nodejs
  ] ++ platformInputs;

  text = ''
    DISCORD_WEBHOOK="https://discord.com/api/webhooks/1418606826433417246/tA2FTwsR5v-MWgRIyiKwJRbRHuK31X_rqggEttTNXi1-k5rIhaW8BpVdOR1SQqdzctle"

    do_beep=true
    do_discord=true
    do_echo=true

    case "''${1:-}" in
      --only-beep)    do_discord=false; shift ;;
      --only-discord) do_beep=false;    shift ;;
      --help|-h)
        echo "uso: notify-beep [--only-beep|--only-discord] [mensagem...]"
        exit 0
        ;;
      --*)
        echo "notify-beep: flag desconhecida: $1" >&2
        echo "uso: notify-beep [--only-beep|--only-discord] [mensagem...]" >&2
        exit 2
        ;;
    esac

    MESSAGE="''${*:-🔔 Notificação do Claude Code}"

    PLATFORM="$(uname -s)"

    # --- Contexto do multiplexador de terminal ---
    CONTEXT=""

    if [ -n "''${TMUX:-}" ] && command -v tmux > /dev/null 2>&1; then
      TMUX_SESSION="$(tmux display-message -p '#S')"
      TMUX_WINDOW="$(tmux display-message -p '#W')"
      TMUX_PANE_IDX="$(tmux display-message -p '#P')"
      CONTEXT="tmux · sessão: $TMUX_SESSION · janela: $TMUX_WINDOW · painel: $TMUX_PANE_IDX"
    elif [ -n "''${ZELLIJ:-}" ]; then
      ZELLIJ_TAB=""
      if command -v zellij > /dev/null 2>&1; then
        ZELLIJ_TAB="$(zellij action current-tab-info 2>/dev/null \
          | sed 's/.*name: "\([^"]*\)".*/\1/')"
      fi
      CONTEXT="zellij · sessão: ''${ZELLIJ_SESSION_NAME:-} · aba: $ZELLIJ_TAB · painel: ''${ZELLIJ_PANE_ID:-}"
    elif [ -n "''${CMUX_WORKSPACE_ID:-}" ]; then
      CONTEXT="cmux · workspace: $CMUX_WORKSPACE_ID · surface: ''${CMUX_SURFACE_ID:-?}"
    fi

    # --- Som + notificação visual ---
    if $do_beep; then
      # Som
      if [ "$PLATFORM" = "Darwin" ]; then
        afplay /System/Library/Sounds/Basso.aiff &
      else
        node -e 'process.stdout.write("\007")' || true
      fi

      # Notificação visual
      if [ -n "''${CMUX_WORKSPACE_ID:-}" ] && command -v cmux > /dev/null 2>&1; then
        # Em foreground: o cmux autentica via processo ancestral
        # e falha com "Failed to write to socket" quando rodado com `&`.
        cmux notify \
          --title "🤖 Claude Code" \
          --subtitle "''${CONTEXT:-}" \
          --body "$MESSAGE" || true
      elif [ "$PLATFORM" = "Darwin" ]; then
        if command -v osascript > /dev/null 2>&1; then
          osascript -e "display notification \"$MESSAGE\" with title \"🤖 Claude Code\"" &
        fi
      else
        # Kitty: OSC 99 (inline, sem &)
        if [ -n "''${KITTY_WINDOW_ID:-}" ]; then
          printf '\x1b]99;i=1:d=0;title=Claude Code;body=%s\x1b\\' "$MESSAGE"
        # Ghostty: mesmo protocolo OSC 99
        elif [ -n "''${GHOSTTY_RESOURCES_DIR:-}" ] || [[ "''${TERM:-}" == *ghostty* ]]; then
          printf '\x1b]99;i=1:d=0;title=Claude Code;body=%s\x1b\\' "$MESSAGE"
        fi
        # notify-send (dunst, mako, gnome, etc.)
        if command -v notify-send > /dev/null 2>&1; then
          notify-send --icon=terminal --app-name="Claude Code" \
            --urgency=normal "🤖 Claude Code" "$MESSAGE" &
        fi
      fi
    fi

    # --- Discord ---
    if $do_discord; then
      DISCORD_WEBHOOK="$DISCORD_WEBHOOK" MESSAGE="$MESSAGE" CONTEXT="$CONTEXT" node -e "
        const url = process.env.DISCORD_WEBHOOK;
        const ctx = process.env.CONTEXT;
        const fields = ctx
          ? [{ name: '📍 Contexto', value: ctx, inline: false }]
          : [];
        const body = JSON.stringify({
          content: '🤖 **Claude Code**',
          embeds: [{
            description: process.env.MESSAGE,
            color: 5814783,
            timestamp: new Date().toISOString(),
            footer: { text: require('os').hostname() },
            fields
          }]
        });
        fetch(url, {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body
        }).then(r => process.exit(r.ok ? 0 : 1));
      " &
    fi

    if $do_echo; then
      echo "$MESSAGE"
      if [ -n "$CONTEXT" ]; then
        echo "  ↳ $CONTEXT"
      fi
    fi
  '';
}
