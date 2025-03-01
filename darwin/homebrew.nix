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
      "lastpass-cli" # lpass cli

      "xcode-kotlin"
      "mint"
      "sourcery"
    ];
    casks = [
      # productivity
      "nikitabobko/tap/aerospace"
      "raycast"

      # communication
      "zoom"
      "slack"

      #code
      "zed"
      "trae"
      "android-studio"

      # browsers
      "arc"
      "zen-browser"

      # terminals
      "ghostty"

      # utils
      "sf-symbols"
      "lastpass"

      "docker"
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
