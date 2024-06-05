{ ... }: {
  programs.git = {
    enable = true;
    delta.enable = true;
    userName = "Guilherme Mangabeira Gregio";
    userEmail = "guilherme@gregio.net";
    signing = {
      key = null; # gnupg decides by mail
      signByDefault = true;
    };
    includes = [
      {
        condition = "gitdir:~/code/stone/";
        contents.user.email = "guilherme.gregio@stone.com.br";
      }
      {
        condition = "gitdir:~/code/dinerama/";
        contents.user.email = "gregio@dinerama.com.br";
      }
    ];
    aliases = {
      c = "commit -am";
      s = "status -s";
      p = "push";
      df = "diff --color --color-words --abbrev";
      co = "checkout";
      lg = "log --graph --pretty=format:'%Cred%h%Creset %Cgreen(%cr) %C(yellow)%d%Creset - %s %C(bold blue)<%an>%Creset'";
      d = "!\"git diff-index --quiet HEAD -- || clear; git --no-pager diff --patch-with-stat\"";
      ignore = "!gi() { curl -L -s https://www.gitignore.io/api/$@ ;}; gi";
      pb = "!\"git fetch --all -p; git branch -vv | grep \": gone]\" | awk '{ print $1 }' | xargs -n 1 git branch -D\"";
    };
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
    ];
    extraConfig = {
      init.defaultBranch = "main";
      pull = {
        ff = false;
        commit = false;
        rebase = true;
      };
      fetch = { prune = true; };
      push.autoSetupRemote = true;
      delta = { line-numbers = true; };
    };
  };
}
