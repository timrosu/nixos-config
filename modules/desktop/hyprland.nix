{ config, pkgs, inputs, vars, ... }:

{
  imports = [
    ./sound.nix
    ./fonts.nix
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
	command = "${pkgs.hyprland}/bin/start-hyprland";
	user = vars.username;
      };
      default_session = initial_session;
    };
  };

  environment.systemPackages = with pkgs; [
    dunst
    wl-clipboard
  ];

  users.users.${vars.username}.extraGroups = [ "video" ];

}
