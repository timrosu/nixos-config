{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    brightnessctl
    wlogout
  ];
  
  wayland.waybar = {
    modulesLeft = [ "custom/logo"  "clock" "cpu" "memory" "temperature" "custom/powerDraw" ];
    modulesCenter = [ "hyprland/workspaces" ];
    modulesRight = [ "network" "bluetooth" "pulseaudio" "battery" ];

    extraModules = {
      "custom/logo" = {
        format = "";
        tooltip = false;
        on-click = "wlogout"; #TODO: rice powermenu
      };

      "custom/powerDraw" = {
        align = 0;
        justify = "left";
        format = "{}";
        interval = 1;
        exec = "~/.config/waybar/scripts/powerdraw.sh";
        return-type = "json";
      };

      temperature = {
	align = 0;
	justify = "left";
	thermal-zone = 4; # type = x86_pkg_temp
	format = " {temperatureC}°C";
	format-critical = " {temperatureC}°C";
	interval = 5;
	critical-threshold = 80;
      };

      bluetooth = {
        align = 0;
        justify = "left";
        controller = "controller1";
        format = "";
        format-disabled = "";
        format-connected = " {device_alias}";
        tooltip-format = "{controller_alias}\t{controller_address}";
        tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
        tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
        on-click = "rofi-bluetooth";
      };

      network = {
        align = 0;
        justify = "left";
        format = "{ifname}";
        format-wifi = "{icon} {essid}";
        format-ethernet = " ";
        format-disconnected = "";
        tooltip-format = "{ifname} via {gwaddr} 󰊗";
        tooltip-format-wifi = "{essid} - {ipaddr}/{cidr}";
        tooltip-format-ethernet = "{ipaddr}/{cidr}";
        tooltip-format-disconnected = "Disconnected";
        max-length = 15;
        on-click = "networkmanager_dmenu";
	format-icons = [
	  "󰤯 "
	  "󰤟 "
	  "󰤢 "
	  "󰤥 "
	  "󰤨 "
	];
      };

      battery = {
        align = 0;
        justify = "left";
        interval = 1;
        states = {
          good = 90;
          warning = 30;
          critical = 20;
        };
        format = "{icon} {capacity}%";
        format-charging = "󰂄 {capacity}%";
        format-plugged = "󰂄 {capacity}%";
        format-alt = "{icon} {time}";
        format-icons = [
          "󰁻"
          "󰁼"
          "󰁾"
          "󰂀"
          "󰂂"
          "󰁹"
        ];
      };
    };
  };
}
