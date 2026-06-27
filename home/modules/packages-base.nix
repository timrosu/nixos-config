{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    fd
    fastfetch
    btop
    acpi
    intel-gpu-tools
    upower
    qutebrowser
  ];
}
