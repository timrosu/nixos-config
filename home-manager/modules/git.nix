{ config, lib, pkgs, vars, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "timrosu";
        email = vars.email.git;
      };
      push = {
        autoSetupRemote = true;
      };
    };
  };
}
