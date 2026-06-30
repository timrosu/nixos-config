{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fd
    fastfetch
    acpi
    upower
  ];
}
