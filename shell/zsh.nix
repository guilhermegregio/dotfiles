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
      export MOBILE_PLATFORM_GITHUB_TOKEN=ghp_
      export MOBILE_PLATFORM_GITHUB_USERNAME=guilhermegregio
      
      export MINT_PATH="$HOME/.mint"
      export MINT_LINK_PATH="$MINT_PATH/bin"
      export PATH=$MINT_LINK_PATH:$PATH
      export CURL_CA_BUNDLE=/Library/Application\ Support/Netskope/STAgent/data/netskope-cert-bundle.pem
      export SSL_CERT_FILE=/Library/Application\ Support/Netskope/STAgent/data/netskope-cert-bundle.pem
      export GIT_SSL_CAPATH=/Library/Application\ Support/Netskope/STAgent/data/netskope-cert-bundle.pem
      export CURL_CA_BUNDLE=/Library/Application\ Support/Netskope/STAgent/data/netskope-cert-bundle.pem
      export SSL_CERT_FILE=/Library/Application\ Support/Netskope/STAgent/data/netskope-cert-bundle.pem
      export GIT_SSL_CAPATH=/Library/Application\ Support/Netskope/STAgent/data/netskope-cert-bundle.pem
      export CURL_CA_BUNDLE=/Library/Application\ Support/Netskope/STAgent/data/netskope-cert-bundle.pem
      export SSL_CERT_FILE=/Library/Application\ Support/Netskope/STAgent/data/netskope-cert-bundle.pem
      export GIT_SSL_CAPATH=/Library/Application\ Support/Netskope/STAgent/data/netskope-cert-bundle.pem

      export ANDROID_SDK_ROOT=$HOME/Users/guilherme.gregio/Library/Android/sdk
      export ANDROID_HOME=$ANDROID_SDK_ROOT
      export NDK_HOME=$ANDROID_HOME/ndk-bundle
      export CUSTOM_GITHUB_PERSONAL_ACCESS_TOKEN_PACKAGE=ghp_
      export TEMP_TAP_SDK_IOS_TOKEN=ghp_
      export APP_STORE_API_KEY_PATH=$HOME/apollo_ios_build/api_key.json
      export PNPM_HOME=~/.pnpm
      
      export PATH=$PATH:$ANDROID_HOME/emulator
      export PATH=$PATH:$ANDROID_HOME/tools
      export PATH=$PATH:$ANDROID_HOME/tools/bin
      export PATH=$PATH:$ANDROID_HOME/platform-tools
      export PATH=$PATH:$PNPM_HOME
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
