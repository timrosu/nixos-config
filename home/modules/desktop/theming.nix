{ config, pkgs, ... }:
let
  cursorFlavor = "mochaDark"; # latte, frappe, macchiato, mocha, mochaDark
  cursorName = "catppuccin-mocha-dark-cursors"; 
in
{
 home.packages = with pkgs; [
    papirus-folders
    catppuccin-cursors.${cursorFlavor}
  ];
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.catppuccin-cursors.${cursorFlavor};
    name = cursorName;
    size = 24;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Breeze-Dark"; #TODO: switch to full catpuccin (or tokyonight)
      package = pkgs.libsForQt5.breeze-gtk;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "lavender";
      };
    };
    cursorTheme = {
      name = cursorName;
      package = pkgs.catppuccin-cursors.${cursorFlavor};
      size = 24;
    };
    gtk3 = {
      extraConfig.gtk-application-prefer-dark-theme = true;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "Breeze-Dark";
      color-scheme = "prefer-dark";
    };
  };

  wayland.windowManager.hyprland.settings = {
    exec_cmd = [
      "hyprctl setcursor ${cursorName} 24"
    ];
    env = [
      {_args = ["HYPRCURSOR_THEME" "${cursorName}"];}
      {_args = ["HYPRCURSOR_SIZE" "24"];}
      {_args = ["XCURSOR_THEME" "${cursorName}"];}
      {_args = ["XCURSOR_SIZE" "24"];}
    ];
  };

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
