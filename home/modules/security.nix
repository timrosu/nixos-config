{ pkgs, ... }:
{
  # Gnome keyring daemon for secrets management
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;

  home.packages = with pkgs; [
    pinentry-rofi
    gnupg
  ];

  services.pcscd.enable = true;
  programs.gnupg.agent = {
   enable = true;
   pinentryFlavor = "rofi";
   enableSSHSupport = true;
  };
}
