{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.wayland.waybar;
in
{
  options.wayland.waybar = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable Waybar status bar";
    };
    modulesLeft = mkOption {
      type = types.listOf types.str;
      default = [ "hyprland/workspaces" ];
      description = "Modules to display on the left side";
    };
    modulesCenter = mkOption {
      type = types.listOf types.str;
      default = [ "clock" ];
      description = "Modules to display in the center";
    };
    modulesRight = mkOption {
      type = types.listOf types.str;
      default = [ "cpu" "memory" "temperature" "pulseaudio" ];
      description = "Modules to display on the right side";
    };
    extraModules = mkOption {
      type = types.attrs;
      default = { };
      description = "Additional module configurations";
    };
    extraSettings = mkOption {
      type = types.attrs;
      default = { };
      description = "Additional waybar settings";
    };
  };

  config = mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      settings = {
        main = ({
          layer = "top";
          position = "top";
          modules-left = cfg.modulesLeft;
          modules-center = cfg.modulesCenter;
          modules-right = cfg.modulesRight;
          reload_style_on_change = true;

          "hyprland/workspaces" = {
	    disable-scroll= false;
	    on-scroll-up= "hyprctl dispatch workspace r-1";
	    on-scroll-down= "hyprctl dispatch workspace r+1";
            on-click = "activate";
            sort-by-number = true;
          };

          clock = {
            format = "{:%H:%M:%S}";
            interval = 1;
            tooltip-format = "{:%a, %d.%m.%Y}\n<tt><small>{calendar}</small></tt>";
            calendar-weeks-pos = "right";
            today-format = "<span color='#7645AD'><b><u>{}</u></b></span>";
            format-calendar = "<span color='#aeaeae'><b>{}</b></span>";
            format-calendar-weeks = "<span color='#aeaeae'><b>W{:%V}</b></span>";
            format-calendar-weekdays = "<span color='#aeaeae'><b>{}</b></span>";
          };

          disk = {
            interval = 300;
            format = "󰋊 {percentage_used}%";
            path = "/";
            align = 0;
            justify = "left";
          };

          cpu = {
            align = 0;
            justify = "left";
	    format = "󰻠 {usage}%";
            # format-critical = "<span color='#c20821'><b>󰻠 {usage}%</b></span>";
            # format-high = "<span color='#bb5613'>󰻠 {usage}%</span>";
            # format-medium = "<span color='#a58315'>󰻠 {usage}%</span>";
            # format-low = "<span color='#6b9fa8'>󰻠 {usage}%</span>";
            interval = 3;
            states = {
              critical = 80;
              high = 50;
              medium = 10;
              low = 0;
            };
            on-click = "kitty btop";
          };

          memory = {
            align = 0;
            justify = "left";
	    format = "󰍛 {percentage}%";
            # format-critical = "<span color='#c20821'><b>󰍛 {percentage}%</b></span>";
            # format-high = "<span color='#bb5613'>󰍛 {percentage}%</span>";
            # format-medium = "<span color='#a58315'>󰍛 {percentage}%</span>";
            # format-low = "<span color='#6b9fa8'>󰍛 {percentage}%</span>";
            interval = 5;
            states = {
              critical = 80;
              high = 60;
              medium = 30;
              low = 0;
            };
          };

          pulseaudio = {
            align = 0;
            justify = "left";
            format = "{icon}  {volume}%";
            format-bluetooth = "{icon}  {volume}%";
            format-muted = "<span foreground='#f38ba8'></span>";
            format-icons = {
              headphone = "";
              "hands-free" = "";
              headset = "";
              phone = "";
              "phone-muted" = "";
              portable = "";
              car = "";
              default = [ "" "" ];
            };
            scroll-step = 1;
            on-click = "pavucontrol";
            ignored-sinks = [ "Easy Effects Sink" ];
          };

          jack = {
            align = 0;
            justify = "left";
            format = "{} 󱎔";
            format-xrun = "{xruns} xruns";
            format-disconnected = "DSP off";
            realtime = true;
          };
        } // cfg.extraModules // cfg.extraSettings );
      };

      style = ''
@define-color base #1e1e2e;
@define-color mantle #181825;
@define-color background #13131f;

@define-color text #cdd6f4;
@define-color subtext0 #a6adc8;
@define-color subtext1 #bac2de;

@define-color surface0 #1a1623;
@define-color surface1 #45475a;
@define-color surface2 #585b70;

@define-color overlay0 #6c7086;
@define-color overlay1 #7f849c;
@define-color overlay2 #9399b2;

@define-color blue #89b4fa;
@define-color lavender #b4befe;
@define-color sapphire #74c7ec;
@define-color sky #89dceb;
@define-color teal #94e2d5;
@define-color green #a6e3a1;
@define-color yellow #f9e2af;
@define-color peach #fab387;
@define-color maroon #eba0ac;
@define-color red #f38ba8;
@define-color mauve #cba6f7;
@define-color pink #f5c2e7;
@define-color flamingo #f2cdcd;
@define-color rosewater #f5e0dc;

* {
    border: none;
    font-size: 14px;
    font-family: "JetBrainsMono Nerd Font,JetBrainsMono NF" ;
    min-width: 30px;
}

window#waybar {
  background: transparent;
 }

#custom-logo {
  color: #5ea1ff;
}

.modules-right {
  border-radius: 24px;
  background: @background;
  opacity: 0.8;
}

.modules-center {
  border-radius: 24px;
  background: @background;
  opacity: 0.8;
}

.modules-left {
  border-radius: 24px;
  background: @background;
  opacity: 0.8;
}

#battery,
#custom-colorpicker,
#custom-powerDraw,
#bluetooth,
#pulseaudio,
#network,
#disk,
#memory,
#backlight,
#cpu,
#temperature,
#custom-weather,
#idle_inhibitor,
#jack,
#tray,
#window {
  padding: 5px 5px;
  color: @text;
}

#workspaces {
    margin: 5px 5px;
    padding: 8px 5px;
    border-radius: 24px;
}
#workspaces button {
    padding: 0px 5px;
    margin: 0px 3px;
    border-radius: 24px;
    color: @overlay2;
    transition: all 0.3s ease-in-out;
}
#workspaces button.active {
    border-radius: 24px;
    min-width: 30px;
    background-size: 300% 300%;
    transition: all 0.3s ease-in-out;
    background-color: @base;
    color: @lavender;
}
#workspaces button:hover {
    border-radius: 24px;
    min-width: 40px;
    background-size: 300% 300%;
    background-color: @surface1;
    color: @mantle;
}

#clock {
  padding: 5px 5px;
  color: #758686;
}

#pulseaudio {
  padding-left: 3px;
}

#temperature.critical,
#pulseaudio.muted {
  color: #c20821;
  padding-top: 0;
}

#battery.charging {
  padding: 5px 5px;
  color: #ffffff;
  background-color: #26A65B;
}

#battery.warning:not(.charging) {
  padding: 5px 5px;
  background-color: #ffbe61;
  color: black;
}

#battery.critical:not(.charging) {
  padding: 5px 5px;
  background-color: #f53c3c;
  color: #ffffff;
  animation-name: blink;
  animation-duration: 0.5s;
  animation-timing-function: linear;
  animation-iteration-count: infinite;
  animation-direction: alternate;
}


/*
@keyframes blink {
    to {
	background-color: #ffffff;
	color: #000000;
    }
}
*/
      '';
    };

    xdg.configFile."waybar/scripts/powerdraw.sh".text = ''
#!${pkgs.bash}/bin/bash
POWER_DIR="/sys/class/power_supply"

for bat in $POWER_DIR/BAT*
do
  if [[ -d $bat && $(<$bat/power_now) -ne 0 ]]; then
    POWER="$(sed -e 's/....$//' -e 's/\(.\)\(.\)$/.\1\2W/' < $bat/power_now || echo 0W)"
    BATTERY="$(grep -oE 'BAT[0-9]+$' <<< $bat)"
  fi
done

if [[ $(<$POWER_DIR/AC/online) -ne 0 ]]
then
  ACTION="charging"
else
  ACTION="discharging"
fi

cat << EOF
{ "text":" $POWER", "tooltip":"$ACTION $BATTERY" }
EOF
    '';

    xdg.configFile."waybar/scripts/powerdraw.sh".executable = true;
  };
}
