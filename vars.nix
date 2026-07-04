let
  username = "timrosu";
  homeDir = "/home/${username}";
  secrets = import ./secrets.nix;
in {
  inherit username;
  fullName = "Tim";

  net = (import ./net.nix { inherit secrets; });

  dir = {
    home = homeDir;
    nixos_config = "${homeDir}/nixos-config";
    hoarder_data = "/hoarder-data";
    impo_data = "/impo-data";
    games = "/games_mx500";
    usb_mountpoint = "${homeDir}/mnt";
    scripts = "${homeDir}/scripts";
    certs = "${homeDir}/certs";
    docker_root = "${homeDir}/docker";
  };

  # default programs
  programs = {
    terminal = "kitty";
    browser = {
      pri = "firefox";
      sec = "qutebrowser";
    };
    filemanager = {
      cli = "yazi";
      gui = "pcmanfm";
    };
    powermenu = "wlogout";
  };

  email = {
    personal = secrets.email.personal;
    git = secrets.email.git;
  };

  timeZone = "Europe/Ljubljana";

  dockerUser = {
    name = "docker-user";
    uid = 1111;
    gid = 1111;
  };
}
