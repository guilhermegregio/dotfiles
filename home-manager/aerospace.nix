{ ... }: {
  home.file.aerospace = {
    target = ".aerospace.toml";
    text = builtins.readFile ./aerospace.toml;
  };
}
