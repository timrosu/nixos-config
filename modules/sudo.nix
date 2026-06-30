{ config, pkgs, vars, ... }:

{
  security.sudo = {
    enable = true;
    wheelNeedsPassword = true;  
    configFile = ''
      Defaults timestamp_timeout=30  # minutes until sudo timeout
    '';
    extraRules = [
      {
        users = [ vars.username ];
        commands = [
          {
            command = "/run/current-system/sw/bin/nixos-rebuild"; 
            options = [ "NOPASSWD" ];
          }
	  { # enable overriding cpu power config
	    command = "/run/current-system/sw/bin/auto-cpufreq --force performance, /run/current-system/sw/bin/auto-cpufreq --force powersave, /run/current-system/sw/bin/auto-cpufreq --force reset";
            options = [ "NOPASSWD" ];
	  }
	  { # enable reboot
	    command = "/run/current-system/sw/bin/systemctl reboot";
	    options = [ "NOPASSWD" ];
	  }
	  {
	    command = "turbostat";
	    options = [ "NOPASSWD" ];
	  }
        ];
      }
    ];
  };
  users.users.${vars.username}.extraGroups = [ "wheel" ];
}
