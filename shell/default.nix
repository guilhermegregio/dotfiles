{ pkgs, ... }: {
  imports = [
      ./zsh.nix
      ./git.nix
    ];

  home = {
    packages = with pkgs; [
      neovim # customized by overlay

      # net tools
      # bind
      # nmap
      # inetutils

      # core
      openssl
      wget
      curl
      fd
      ripgrep # fast search

      # utilities
      lastpass-cli
      gh # github cli tool
      # grc # colored log output
      # gitAndTools.delta # pretty diff tool
      # sshfs # mount folders via ssh
      # glab # gitlab cli tool
      # graph-easy # draw graphs in the terminal
      # cht-sh # cheat sheet -> cht python read file
      # tealdeer # community driven man pages
      # dive # analyse docker images
      # hyperfine # benchmark tool
      # sipcalc # ip subnet calculator
      # youtube-dl # download youtube videos
      # ffmpeg # video editing and cutting
      # rclone # sync files
      # duf # disk usage
      httpie # awesome alternative to curl
      # mongodb-tools
      # pulumi-bin # manage infrastructure as code
      # viddy # terminal watch command
      # unixtools.watch # watches commands
      # yq-go # yaml, toml parser
      # termdown # terminal countdown
      # tmate # share terminal via web
      # silicon # create code snippets as images
      # crane # container registry tool
      # ytt # yaml templating engine
      # zk # zettelkasten
      # mask # taskrunner
      # diskonaut # explore disk size
      # gnupg # gpg
      # gping # ping with a graph
      # ruby # scripting language
      # corepack # node wrappers
      # redis # to use the cli
      # k6 # load testing tool
      # slides # terminal presentation tool
      # presenterm # presentation tool
      # asdf-vm # managing different versions
      # comma # run nix binaries on demand
      # sshuttle # vpn over ssh

      # gnu binaries
      # coreutils-full # multiple tools
      # gnutar
      # gnused
      # gnugrep
      # gnumake
      # gzip
      # findutils
      # gawk

      # kubernetes stuff
      # kubectl
      # krew # kubectl plugins
      # kubie # fzf kubeconfig browser
      # kind # k8s in docker
      # velero # k8s backup tool
      # fluxcd # automation
      # kubent # check for deprecations
      # termshark # tui for wireshark
      # prometheus # prometheus linter
      # dyff # better kubectl diff
      # kubebuilder # generate controller
      # kubernetes-helm # deploy applications

      # cloud
      # google-cloud-sdk
      # awscli2
      # azure-cli
      # openstackclient
      # s3cmd

      # programming

      ## python
      # python3
      # poetry # python tools
      # rustup # rust

      ## node
      # deno # node runtime
      # nodejs
      # nodePackages.npm
      # nodePackages.yarn
      # nodePackages.expo-cli

      ## golang
      # golangci-lint

      ## kotlin
      # ktlint
      # kotlin
      # gradle
    ];

    shellAliases = {
      # builtins
      size = "du -sh";
      cp = "cp -i";
      mkdir = "mkdir -p";
      df = "df -h";
      free = "free -h";
      du = "du -sh";
      # del = "rm -rf";
      # lst = "ls --tree -I .git";
      # lsl = "ls -l";
      # lsa = "ls -a";
      # null = "/dev/null";

      # overrides
      # cat = "bat";
      # top = "btop";
      # htop = "btop";
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
    };

    sessionPath = [
      # "$HOME/go/bin"
      "$HOME/.local/bin"
      # "$HOME/.cargo/bin"
      # "$HOME/.krew/bin"
    ];

    sessionVariables = {
      # GO111MODULE = "on";
      EDITOR = "nvim";
      VISUAL = "nvim";
      NIXPKGS_ALLOW_UNFREE = "1";
      # PULUMI_CONFIG_PASSPHRASE = "";
    };
  };

  programs = {
    # let home-manager manage itself
    home-manager.enable = true;

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    # shell integrations are enabled by default
    zoxide.enable = true; # autojump
    jq.enable = true; # json parser
    bat.enable = true; # pretty cat
    # lazygit.enable = true; # git tui
    # nnn.enable = true; # file browser
    btop.enable = true; # htop alternative
    # nushell.enable = true; # zsh alternative
    # broot.enable = true; # browser big folders

    # sqlite browser history
    # atuin = {
    #   enable = true;
    #   flags = [ "--disable-up-arrow" ];
    #   settings = {
    #     inline_height = 20;
    #     style = "compact";
    #   };
    # };

    # pretty prompt
    starship = {
      enable = true;
      settings = {
        add_newline = false;
        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[✗](bold red)";
        };
      };
    };

    # pretty ls
    # lsd = {
    #   enable = true;
    #   enableAliases = true;
    # };

    # go = {
    #   enable = true;
    #   package = pkgs.go_1_22;
    #   goPath = "go";
    #   goBin = "go/bin";
    #   goPrivate = [ ];
    # };

    htop = {
      enable = true;
      settings = {
        tree_view = true;
        show_cpu_frequency = true;
        show_cpu_usage = true;
        show_program_path = false;
      };
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand =
        "fd --type f --hidden --follow --exclude .git --exclude .vim --exclude .cache --exclude vendor --exclude node_modules";
      defaultOptions = [
        "--border sharp"
        "--inline-info"
      ];
    };

    # snippet manager
    # pet = {
    #   enable = true;
    #   # <param=default-value> -> use variables
    #   snippets = [
    #     {
    #       command = "git rev-parse --short HEAD";
    #       description = "show short git rev";
    #       output = "888c0f8";
    #       tag = [ "git" ];
    #     }
    #     {
    #       description = "show size of a folder";
    #       command = "du -hs <folder>";
    #     }
    #     {
    #       description = "garden kubeconfig from ske-ci ondemand cluster";
    #       command =
    #         "kubectl get secret garden-kubeconfig-for-admin -n garden -o jsonpath='{.data.kubeconfig}' | base64 -d > garden-kubeconfig-for-admin.yaml";
    #     }
    #     {
    #       description = "get all images used in a kubernetes cluster";
    #       command =
    #         "kubectl get pods --all-namespaces -o jsonpath=\"{.items[*].spec['initContainers', 'containers'][*].image}\" | tr -s '[[:space:]]' '\n' | sort | uniq -c";
    #     }
    #   ];
    # };
  };
}
