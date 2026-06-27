{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fd
    fastfetch
    acpi
    intel-gpu-tools
    upower
  ];
}
