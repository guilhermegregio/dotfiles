{ pkgs, ... }: {
  home.file = {
    "~/.config/ghostty/config".source = ./ghostty-config;
  };
  # programs.ghostty = {
  #   enable = true;
  #   package = pkgs.ghostty;

  #   settings = {
  #     theme = "catppuccin-mocha";
  #     mouse-hide-while-typing = true;
  #     keybind = "global:cmd+/=toggle_quick_terminal";
  #     # Some macOS settings
  #     macos-option-as-alt = true;
  #     window-decoration = "none";

  #     # Disables ligatures
  #     # font-feature = ["-liga" "-dlig" "-calt"];
  #   };
  # };
}
