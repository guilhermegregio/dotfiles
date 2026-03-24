{ ... }: {
  programs.git = {
    enable = true;
    lfs.enable = true;
    # mantem o comportamento legado de assinatura (home.stateVersion < 25.05)
    signing.format = "openpgp";
    includes = [
      {
        condition = "gitdir:~/code/stone/";
        contents.user.email = "guilherme.gregio@stone.com.br";
      }
    ];
    ignores = [
      # ide
      ".idea"
      ".vs"
      ".vsc"
      ".vscode"
      # npm
      "node_modules"
      "npm-debug.log"
      # python
      "__pycache__"
      "*.pyc"

      ".ipynb_checkpoints" # jupyter
      "__sapper__" # svelte
      ".DS_Store" # mac
      "kls_database.db" # kotlin lsp
      "result"
      "tags"

      # nix envs
      ".envrc"
      ".direnv"
      ".claude"
    ];
    settings = {
      user = {
        name = "Guilherme Mangabeira Gregio";
        email = "guilherme@gregio.net";
      };
      alias = {
        c = "commit -am";
        s = "status -s";
        p = "push";
        df = "diff --color --color-words --abbrev";
        co = "checkout";
        lg = "log --graph --pretty=format:'%Cred%h%Creset %Cgreen(%cr) %C(yellow)%d%Creset - %s %C(bold blue)<%an>%Creset'";
        d = "!git diff-index --quiet HEAD -- || clear; git --no-pager diff --patch-with-stat";
        ignore = "!gi() { curl -L -s https://www.gitignore.io/api/$@ ;}; gi";
        pb = "!git fetch --all -p; git branch -vv | rg \": gone]\" | awk '{ print $1 }' | xargs -n 1 git branch -D";
      };
      init.defaultBranch = "main";
      pull = {
        ff = false;
        commit = false;
        rebase = true;
      };
      fetch = { prune = true; };
      push.autoSetupRemote = true;
      http.sslCAInfo = "/etc/ssl/certs/combined-ca.pem";
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = { line-numbers = true; };
  };
}
