{
  # battery stuff
  powerManagement.enable = true;
  services.tlp = {
    enable = true;
    settings = {
      # Internal
      START_CHARGE_THRESH_BAT0 = 80;
      STOP_CHARGE_THRESH_BAT0 = 90;
      # External
      START_CHARGE_THRESH_BAT1 = 80;
      STOP_CHARGE_THRESH_BAT1 = 90;
    };
  };

  # cpu stuff
  services.thermald.enable = true;
  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
	governor = "ondemand";
	turbo = "auto";
      };
      charger = {
	governor = "conservative";
	turbo = "auto";
      };
    };
  };
}
