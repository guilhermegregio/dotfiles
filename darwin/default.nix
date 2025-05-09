{ pkgs, ... }: {
  imports = [ ./homebrew.nix ];

  environment = {
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      NIX_SSL_CERT_FILE = "/etc/ssl/certs/combined-ca.pem";
      SSL_CERT_FILE = "/etc/ssl/certs/combined-ca.pem";
      CURL_CA_BUNDLE = "/etc/ssl/certs/combined-ca.pem";
      GIT_SSL_CAPATH = "/etc/ssl/certs/combined-ca.pem";
      REQUESTS_CA_BUNDLE = "/etc/ssl/certs/combined-ca.pem";
    };
  };

  programs = { zsh.enable = true; };

  services = {
    # FIXME: driver issues
    karabiner-elements.enable = false;
    sketchybar = {
      enable = false;
      extraPackages = with pkgs; [ jq gh ];
    };
  };

  networking = {
    knownNetworkServices = [ "Wi-Fi" ];
    dns = [ "9.9.9.9" "1.1.1.1" "8.8.8.8" ];
  };

  fonts.packages = with pkgs; [
    pkgs.nerd-fonts.jetbrains-mono
    sketchybar-app-font
  ];

  system = {
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };

    defaults = {
      ".GlobalPreferences"."com.apple.mouse.scaling" = 4.0;
      spaces.spans-displays = false;
      universalaccess = {
        # FIXME: cannot write universal access
        #reduceMotion = true;
        #reduceTransparency = true;
      };

      dock = {
        autohide = true;
        autohide-delay = 0.0;
        autohide-time-modifier = 0.0;
        orientation = "right";
        dashboard-in-overlay = true;
        largesize = 85;
        tilesize = 50;
        magnification = true;
        launchanim = false;
        mru-spaces = false;
        show-recents = false;
        show-process-indicators = false;
        static-only = true;
      };

      finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        CreateDesktop = false;
        FXDefaultSearchScope = "SCcf"; # current folder
        QuitMenuItem = true;
      };

      NSGlobalDomain = {
        _HIHideMenuBar = false;
        AppleFontSmoothing = 0;
        AppleInterfaceStyle = "Dark";
        AppleKeyboardUIMode = 3;
        AppleScrollerPagingBehavior = true;
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        InitialKeyRepeat = 10;
        KeyRepeat = 2;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSAutomaticWindowAnimationsEnabled = false;
        NSWindowResizeTime = 0.0;
        NSWindowShouldDragOnGesture = true;
        "com.apple.sound.beep.feedback" = 0;
        "com.apple.trackpad.scaling" = 2.0;
      };
    };
  };
}
