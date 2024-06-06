{ pkgs, pkgs-zsh-fzf-tab, ... }: {
  programs.zsh = {
    enable = true;

    autosuggestion = {
      enable = true;
    };

    enableCompletion = false;
    autocd = true;
    dotDir = ".config/zsh";
    #defaultKeymap = "viins"; #vicmd or viins

    history = {
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = true; # ignore commands starting with a space
      save = 20000;
      size = 20000;
      share = true;
    };

    initExtra = ''
      # used for homebrew
      export XDG_DATA_DIRS=$XDG_DATA_DIRS:/opt/homebrew/share
    '';

    shellAliases = {

      # overrides
      cat = "bat";
      top = "btop";
      htop = "btop";
      # ping = "gping";
      # diff = "delta";
      # ssh = "TERM=screen ssh";
      # python = "python3";
      # pip = "python3 -m pip";
      # venv = "python3 -m venv";
      # j = "z";

      # programs
      g = "git";
      # k = "kubectl";
      # d = "docker";
      # kca = "kubectl apply -f";
      # dc = "docker-compose";
      # poe = "poetry";
      # tf = "terraform";
      # nr = "npm run";
      # py = "python";
      # pu = "pulumi";
      # cht = "cht.sh"; # terminal cheat sheet

      psf = "ps -aux | grep";
      lsf = "ls | grep";

      weather = "curl -4 http://wttr.in/Koeln";

      # nix
      ne = "zed ~/.nixpkgs";
      nf = "nix run nix-darwin -- switch --flake ~/.nixpkgs";
      nclean =
        "nix-collect-garbage -d && nix-store --gc && nix-store --verify --check-contents && nix store optimise";
    };

    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }
      {
        name = "fast-syntax-highlighting";
        src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
      }
      {
        name = "forgit";
        src = "${pkgs.zsh-forgit}/share/zsh/zsh-forgit";
      }
      {
        name = "fzf-tab";
        src = "${pkgs-zsh-fzf-tab.zsh-fzf-tab}/share/fzf-tab";
      }
    ];
    prezto = {
      enable = true;
      caseSensitive = false;
      utility.safeOps = true;
      editor = {
        dotExpansion = true;
        keymap = "vi";
      };
      pmodules = [ "autosuggestions" "directory" "editor" "git" "terminal" ];
    };
  };
}
