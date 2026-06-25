{ config, pkgs, inputs, vars, ... }:

{
  fonts.packages = with pkgs; [
    nerd-fonts.blex-mono
    nerd-fonts.jetbrains-mono
    ibm-plex
    font-awesome
  ];
}
