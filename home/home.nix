{ hostName, config, pkgs, inputs, vars, ... }:

{
  imports = [
    ./modules/packages-base.nix
    ./modules/python.nix
    ./modules/git.nix

    # host config
    ./hosts/${hostName}/default.nix
  ];

  home.username = vars.username;
  home.homeDirectory = "/home/${vars.username}";
  home.stateVersion = "26.05";

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.zsh.enable = true;

  # Let Home Manager install and manage itself.
  #programs.home-manager.enable = true;

  xdg.enable = true;
}
