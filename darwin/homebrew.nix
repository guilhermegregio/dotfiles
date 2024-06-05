{ ... }: {
  homebrew = {
    enable = true;
    global = { autoUpdate = false; };
    # will not be uninstalled when removed
    masApps = {
      # Xcode = 497799835;
      # Transporter = 1450874784;
      # VN = 1494451650;
    };
    onActivation = {
      # "zap" removes manually installed brews and casks
      cleanup = "zap";
      autoUpdate = false;
      upgrade = false;
    };
    brews = [
      "borders" # borders for windows
    ];
    casks = [
      "nikitabobko/tap/aerospace"
      "raycast"

      "wezterm"
      "zoom"
      "slack"
      "zed" # editor

      "arc"

      "sf-symbols"
    ];
    taps = [
      # default
      "homebrew/bundle"
      "homebrew/services"
      # custom
      "FelixKratz/homebrew-formulae" # borders
    ];
  };
}
