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
      extraActivationCommands = ''
        brew trust --formula FelixKratz/homebrew-formulae/borders || true
      '';
    };
    brews = [
      "borders" # borders for windows

      "xcode-kotlin"
      "mint"
      "sourcery"
      "carthage"
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
      "android-studio"
      "intellij-idea-ce"
      "dbeaver-community"

      # browsers
      "arc"
      "zen"
      "google-chrome"

      # terminals
      "ghostty"

      # utils
      "sf-symbols"
      "docker-desktop"
      "obs"
    ];
    taps = [
      # default
      #"homebrew/bundle"
      #"homebrew/services"
      # custom
      "FelixKratz/homebrew-formulae" # borders
    ];
  };
}
