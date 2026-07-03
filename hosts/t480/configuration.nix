{ config, pkgs, vars, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
    ./power.nix
    ../../modules/common.nix
    ../../modules/shell.nix
    ../../modules/desktop/hyprland.nix
    ../../modules/sudo.nix
    ../../modules/utilities.nix
    ../../modules/virtual-machines/libvirt.nix
    ../../modules/hardware/intel/intel-qsv.nix
  ];

    # Boot configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Gnome keyring daemon for secrets management
  services.gnome.gnome-keyring.enable = true;

  hardware.bluetooth.enable = true;
  programs.kdeconnect.enable = true;

  environment.systemPackages = with pkgs; [
    ntfs3g
    dnsmasq
    wireguard-tools
    direnv # for python projects so vscode recognizes nix shell
    nix-direnv 
  ];

  # for platformio
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    zlib
    glibc
  ];

  boot.kernelModules = [ "drivetemp" ];  # for reading HDD temps
  users.users.${vars.username}.extraGroups = [ "dialout" ]; # for flashing microcontrolers

# fingerprint sensor
  services."06cb-009a-fingerprint-sensor" = {                                 
    enable = true;                                                            
    backend = "libfprint-tod";                                                
    calib-data-file = ./calib-data.bin;                
  };
  security.pam.services.login.fprintAuth = true;
  security.pam.services.sudo.fprintAuth = true;

  system.stateVersion = "26.05";
}
