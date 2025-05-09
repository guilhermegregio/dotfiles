{ pkgs ? import <nixpkgs> {} }:

pkgs.writeShellApplication {
  name = "xcode15";

  runtimeInputs = with pkgs; [
    bash
  ];

  text = ''
    XCODE_PATH="/Applications/Xcode15.2.app"

    XCODE_EXECUTABLE="$XCODE_PATH/Contents/MacOS/Xcode"

    # Launch Xcode
    if [ -e "$XCODE_EXECUTABLE" ]; then
        echo "Launching Xcode..."
        "$XCODE_EXECUTABLE"
    else
        echo "Xcode not found."
    fi
  '';
}
