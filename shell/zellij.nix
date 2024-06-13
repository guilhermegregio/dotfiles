{ ... }: {
  programs.zellij = {
    enable = true;
  };

  home.file.zellij = {
    target = ".config/zellij/config.kdl";
    text = builtins.readFile ./zellij.kdl;
  };
}