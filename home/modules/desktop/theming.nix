{ inputs, pkgs, ... }:
let
  theme_flavor = "mocha"; # latte, frappe, macchiato, mocha, mochaDark
  theme_name = "catppuccin-mocha-dark-cursors"; 
  theme_accent = "lavender";
in
{
  imports = [inputs.catppuccin.homeModules.catppuccin];

  catppuccin = {
    # enable = true; # sets catppuccin everywhere
    flavor = "mocha";
    accent = "lavender";

    cursors.enable = true;
    gtk.icon.enable = true;
    dunst.enable = true;
    wlogout.enable = true;
  };

  # home.packages = with pkgs; [
    # papirus-folders
    # catppuccin-papirus-folders.override
    # catppuccin-cursors.${flavor}
  # ];
  
  # home.pointerCursor = {
  #   gtk.enable = true;
  #   x11.enable = true;
  #   # package = pkgs.catppuccin-cursors.${theme_flavor};
  #   name = theme_name;
  #   size = 24;
  # };

  # wayland.windowManager.hyprland.settings = {
  #   exec_cmd = [
  #     "hyprctl setcursor ${theme_name} 24"
  #   ];
  #   env = [
  #     {_args = ["HYPRCURSOR_THEME" "${theme_name}"];}
  #     {_args = ["HYPRCURSOR_SIZE" "24"];}
  #     {_args = ["XCURSOR_THEME" "${theme_name}"];}
  #     {_args = ["XCURSOR_SIZE" "24"];}
  #   ];
  # };


  # gtk = {
  #   enable = true;
  #   catppuccin = {
  #     enable = true;
  #     flavor = "mocha";
  #     accent = theme_accent;
  #     size = "standard";
  #     tweaks = [ "normal" ];
  #   };
    # iconTheme = {
    #   name = "Papirus-Dark";
    #   package = pkgs.catppuccin-papirus-folders.override {
    #     flavor = "mocha";
    #     accent = theme_accent;
    #   };
    # };
    # cursorTheme = {
    #   name = theme_name;
    #   package = pkgs.catppuccin-cursors.${theme_flavor};
    #   size = 24;
    # };
    # gtk3 = {
    #   extraConfig.gtk-application-prefer-dark-theme = true;
    # };
  # };

  # dconf.settings = {
  #   "org/gnome/desktop/interface" = {
  #     gtk-theme = "Breeze-Dark";
  #     color-scheme = "prefer-dark";
  #   };
  # };

  # qt = {
  #   enable = true;
  #   platformTheme = "qtct";
  #   style.name = "kvantum";
  # };
  #
  # xdg.configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini { }).generate "kvantum.kvconfig" {
  #   General.theme = "Catppuccin-Macchiato-Blue";
  # };
} 
