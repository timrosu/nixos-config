{ config, pkgs, inputs, ... }:

{
  imports = [
    ./packages.nix
    ../../modules/firefox
    # ../../modules/firefox/extensions.nix
    # ../../modules/firefox/bookmarks.nix
    ../../modules/vscode.nix
    ../../modules/desktop/hyprland-base.nix
    ../../modules/desktop/waybar-base.nix
    ../../modules/desktop/hyprlock.nix
    ../../modules/desktop/theming.nix
    ../../modules/desktop/hyprpaper.nix
    ../../modules/desktop/kitty.nix
    ../../modules/desktop/rofi.nix
    ../../modules/desktop/hyprsunset.nix
    ../../modules/protonmail-bridge.nix
    ../../modules/thunderbird.nix

    ../../modules/cli/yazi
    ../../modules/cli/btop.nix
    ../../modules/cli/lazygit.nix
  ];
}
