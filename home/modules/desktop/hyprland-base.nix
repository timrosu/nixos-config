{ config, lib, pkgs, inputs, hostName, vars, ... }:

with lib;

let
  cfg = config.wayland.hyprland;
  lua = lib.generators.mkLuaInline;
  prog = vars.programs;


  baseSettings = {
    config = {
      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 2;
        col.active_border = {
          colors = ["rgba(33ccffee)" "rgba(00ff99ee)"]; 
          angle = 90;
        };
        col.inactive_border = "rgba(595959aa)";
        layout = "dwindle";
      };

      decoration = {
        rounding = 2;
        blur = { enabled = false; size = 3; passes = 1; };
        shadow = { enabled = false; };
      };

      input = {
        kb_layout = "us,si";
        kb_options = "grp:win_space_toggle,caps:swapescape";
        follow_mouse = 1;
        touchpad.natural_scroll = true;
      };
    };

    gesture = [
      { # resize current window
        fingers = 2;
        direction = "pinch";
        mode = "live";
        mods = "SHIFT";
        action = "resize";
      }
      { # resize mouse cursor
        fingers = 2;
        direction = "pinch";
        mode = "live";
        mods = "SUPER";
        action = "cursor_zoom";
      }

      { # switch workspaces
        fingers = 3;
        direction = "horizontal";
        action = "workspace";
      }
      { # toggle scratchpad 
        fingers = 3;
        direction = "down";
        action = "special";
        workspace_name = "magic";
      }

      { # maximize current window
        fingers = 3;
        direction = "up";
        action = "fullscreen";
        mode = "maximize";
      }
      { # toggle fullscreen
        fingers = 3;
        direction = "pinchin";
        action = "fullscreen";
        mode = "fullscreen";
      }
      { # toggle float
        fingers = 3;
        direction = "pinchout";
        action = "float";
        mode = "float";
      }
    ];

    bind = [
      ### Window management stuff ###
      # jump across windows
      {_args = ["SUPER + h" (lua ''hl.dsp.focus { direction = "l" }'')];}
      {_args = ["SUPER + j" (lua ''hl.dsp.focus { direction = "d" }'')];}
      {_args = ["SUPER + k" (lua ''hl.dsp.focus { direction = "u" }'')];}
      {_args = ["SUPER + l" (lua ''hl.dsp.focus { direction = "r" }'')];}
      
      # cycle windows
      {_args = ["SUPER + c" (lua ''hl.dsp.window.cycle_next { next = false }'')];}
      {_args = ["SUPER + SHIFT + c" (lua ''hl.dsp.window.cycle_next'')];}

      # resize window
      {_args = ["SUPER + ALT + h" (lua ''hl.dsp.window.resize({ x = -40, y = 0, relative = true })'') {repeating = true;}];}
      {_args = ["SUPER + ALT + j" (lua ''hl.dsp.window.resize({ x = 0, y = 40, relative = true })'')  {repeating = true;}];}
      {_args = ["SUPER + ALT + k" (lua ''hl.dsp.window.resize({ x = 0, y = -40, relative = true })'') {repeating = true;}];}
      {_args = ["SUPER + ALT + l" (lua ''hl.dsp.window.resize({ x = 40, y = 0, relative = true })'') {repeating = true;}];}

      # move window to workspace
      # absolute
      {_args = ["SUPER + SHIFT + 1" (lua ''hl.dsp.window.move({ workspace = 1 })'')];}
      {_args = ["SUPER + SHIFT + 2" (lua ''hl.dsp.window.move({ workspace = 2 })'')];}
      {_args = ["SUPER + SHIFT + 3" (lua ''hl.dsp.window.move({ workspace = 3 })'')];}
      {_args = ["SUPER + SHIFT + 4" (lua ''hl.dsp.window.move({ workspace = 4 })'')];}
      {_args = ["SUPER + SHIFT + 5" (lua ''hl.dsp.window.move({ workspace = 5 })'')];}
      {_args = ["SUPER + SHIFT + 6" (lua ''hl.dsp.window.move({ workspace = 6 })'')];}
      {_args = ["SUPER + SHIFT + 7" (lua ''hl.dsp.window.move({ workspace = 7 })'')];}
      {_args = ["SUPER + SHIFT + 8" (lua ''hl.dsp.window.move({ workspace = 8 })'')];}
      {_args = ["SUPER + SHIFT + 9" (lua ''hl.dsp.window.move({ workspace = 9 })'')];}
      # relative
      {_args = ["SUPER + SHIFT + bracketleft" (lua ''hl.dsp.window.move({ workspace = "r-1" })'')];}
      {_args = ["SUPER + SHIFT + bracketright" (lua ''hl.dsp.window.move({ workspace = "r+1" })'')];}

      # jump to workspace
      # absolute
      {_args = ["SUPER + 1" (lua ''hl.dsp.focus { workspace = 1 }'')];}
      {_args = ["SUPER + 2" (lua ''hl.dsp.focus { workspace = 2 }'')];}
      {_args = ["SUPER + 3" (lua ''hl.dsp.focus { workspace = 3 }'')];}
      {_args = ["SUPER + 4" (lua ''hl.dsp.focus { workspace = 4 }'')];}
      {_args = ["SUPER + 5" (lua ''hl.dsp.focus { workspace = 5 }'')];}
      {_args = ["SUPER + 6" (lua ''hl.dsp.focus { workspace = 6 }'')];}
      {_args = ["SUPER + 7" (lua ''hl.dsp.focus { workspace = 7 }'')];}
      {_args = ["SUPER + 8" (lua ''hl.dsp.focus { workspace = 8 }'')];}
      {_args = ["SUPER + 9" (lua ''hl.dsp.focus { workspace = 9 }'')];}
      # relative
      {_args = ["SUPER + bracketleft" (lua ''hl.dsp.focus({ workspace = "-1" })'')];}
      {_args = ["SUPER + bracketright" (lua ''hl.dsp.focus({ workspace = "+1" })'')];}

      # scratchpad
      {_args = ["SUPER + S" (lua ''hl.dsp.workspace.toggle_special("magic")'')];}
      {_args = ["SUPER + SHIFT + S" (lua ''hl.dsp.window.move({ workspace = "special:magic" })'')];}

      # jump to previous workspace
      {_args = ["SUPER + TAB" (lua ''hl.dsp.focus({ workspace = "previous" })'')];}
      {_args = ["SUPER + SHIFT + TAB" (lua ''hl.dsp.focus({ workspace = "previous_per_monitor"; on_current_monitor = true })'')];}
      # jump to previous window
      {_args = ["SUPER + grave" (lua ''hl.dsp.focus({ last = true })'')];}
      {_args = ["SUPER + SHIFT + grave" (lua ''hl.dsp.focus({ last = true; on_current_monitor = true })'')];}

      # set window mode
      {_args = ["SUPER + T" (lua ''hl.dsp.window.center()'')];} # tiling
      {_args = ["SUPER + SHIFT + T" (lua ''hl.dsp.window.pseudo( {action = "toggle" })'')];} # pseudo tiling
      {_args = ["SUPER + SHIFT + F" (lua ''function() hl.dsp.window.float({ action = "toggle" }); hl.dsp.window.center() end'')];} # floating
      {_args = ["SUPER + F" (lua ''hl.dsp.window.fullscreen({ mode = "fullscreen"; action = "toggle"})'')];} # fullscreen
      {_args = ["SUPER + M" (lua ''hl.dsp.window.fullscreen({ mode = "maximized"; action = "toggle"})'')];} # maximized

      # mouse magic
      {_args = ["SUPER + mouse:272" (lua ''hl.dsp.window.drag()'')];} # drag window
      {_args = ["SUPER + SHIFT + mouse:272" (lua ''hl.dsp.window.resize()'')];} # resize window
      # {_args = ["SUPER + mouse:272" (lua ''hl.dsp.window.resize()'')];} # TODO: pointer zoom

      ### apps ###
      # main
      {_args = ["SUPER + W" (lua ''hl.dsp.window.close()'')];} # close window
      {_args = ["SUPER + SHIFT + W" (lua ''hl.dsp.window.kill()'')];} # kill window
      {_args = ["SUPER + ALT + X" (lua ''hl.dsp.exec_cmd("hyprlock")'')];} # lock the screen
      {_args = ["SUPER + M" (lua ''hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit")'')];} # idk
      {_args = ["SUPER + V" (lua ''hl.dsp.exec_cmd("cliphist list | rofi -dmenu | cliphist decode | wl-copy")'')];} # clipboard history popup
      {_args = ["SUPER + R" (lua ''hl.dsp.exec_cmd("rofi -show run")'')];} # rofi run
      {_args = ["SUPER + Q" (lua ''hl.dsp.exec_cmd("rofi -show combi -modes combi -combi-modes 'window,drun,run'")'')];} # rofi combo

      # powermenu
      {_args = ["SUPER + ESCAPE" (lua ''hl.dsp.exec_cmd("${prog.powermenu}")'') { locked = true; } ];}

      # browser
      {_args = ["SUPER + B" (lua ''hl.dsp.exec_cmd("${prog.browser.pri}")'')];}
      {_args = ["SUPER + SHIFT + B" (lua ''hl.dsp.exec_cmd("${prog.browser.sec}")'')];}

      # terminal
      {_args = ["SUPER + X" (lua ''hl.dsp.exec_cmd("${prog.terminal}")'')];} # terminal
      {_args = ["SUPER + SHIFT + X" (lua ''hl.dsp.exec_cmd("${prog.terminal}")'') { float = true; } ];} # terminal
      
      # calculator
      {_args = ["XF86Calculator" (lua ''hl.dsp.exec_cmd("rofi -show calc -modi calc -no-show-match -no-sort")'')];}
      {_args = ["SUPER + SHIFT + R" (lua ''hl.dsp.exec_cmd("rofi -show calc -modi calc -no-show-match -no-sort")'')];}

      # file manager
      {_args = ["SUPER + E" (lua ''hl.dsp.exec_cmd("${prog.terminal} ${prog.filemanager.cli}")'')];}
      {_args = ["SUPER + SHIFT + E" (lua ''hl.dsp.exec_cmd("${prog.terminal} ${prog.filemanager.cli}", { float = true, move = {"monitor_w * 0.25", "monitor_h * 0.25"}, size = {"monitor_w * 0.5", "monitor_h * 0.5"} })'')];}
      {_args = ["SUPER + CTRL + E" (lua ''hl.dsp.exec_cmd("${prog.filemanager.gui}")'')];}

      # pulsemixer
      {_args = ["SUPER + A" (lua ''hl.dsp.exec_cmd("${prog.terminal} pulsemixer", { float = true, move = {"monitor_w * 0.25", "monitor_h * 0.25"}, size = {"monitor_w * 0.5", "monitor_h * 0.5"} })'')];}

      ## bluetooth
      # rofi
      {_args = ["SUPER + F10" (lua ''hl.dsp.exec_cmd("rofi-bluetooth")'')];}
      # tui
      {_args = ["SUPER + SHIFT + F10" (lua ''hl.dsp.exec_cmd("${prog.terminal} bluetuith", { float = true, move = {"monitor_w * 0.25", "monitor_h * 0.25"}, size = {"monitor_w * 0.5", "monitor_h * 0.5"} })'')];}

      # wifi rofi
      {_args = ["SUPER + F8" (lua ''hl.dsp.exec_cmd("networkmanager_dmenu")'')];}

      ### custom actions ###
      # change volume
      {_args = ["XF86AudioMute" (lua ''hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")'') {locked = true;} ];}
      {_args = ["XF86AudioLowerVolume" (lua ''hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")'') {locked = true; repeating = true;} ];}
      {_args = ["XF86AudioRaiseVolume" (lua ''hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+")'') {locked = true; repeating = true;} ];}

      # toggle keeb lang (notification)
      {_args = ["SUPER + Space" (lua ''hl.dsp.exec_cmd("hyprctl notify -1 1500 0 $(hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | first(.active_keymap)')")'') {locked = true;} ];}

      ## media controls ##
      # for desktop
      {_args = ["XF86AudioPlay" (lua ''hl.dsp.exec_cmd("playerctl play-pause")'') {locked = true;} ];}
      {_args = ["XF86AudioPrev" (lua ''hl.dsp.exec_cmd("playerctl previous")'') {locked = true;} ];}
      {_args = ["XF86AudioNext" (lua ''hl.dsp.exec_cmd("playerctl next")'') {locked = true;} ];}
      # for my laptop
      {_args = ["SHIFT + XF86AudioMute" (lua ''hl.dsp.exec_cmd("playerctl play-pause")'') {locked = true;} ];}
      {_args = ["SHIFT + XF86AudioLowerVolume" (lua ''hl.dsp.exec_cmd("playerctl previous")'') {locked = true;} ];}
      {_args = ["SHIFT + XF86AudioRaiseVolume" (lua ''hl.dsp.exec_cmd("playerctl next")'') {locked = true;} ];}

      ## cpu power overrides ##
      {_args = ["XF86Favorites" (lua ''hl.dsp.exec_cmd("sudo auto-cpufreq --force performance")'') {locked = true;} ];}
      {_args = ["SHIFT + XF86Favorites" (lua ''hl.dsp.exec_cmd("sudo auto-cpufreq --force reset")'') {locked = true;} ];}
      {_args = ["CTRL + XF86Favorites" (lua ''hl.dsp.exec_cmd("sudo auto-cpufreq --force powersave")'') {locked = true;} ];}

    ];

    on = [
      {
        _args = [
          "hyprland.start"
          (lua ''
            function()
              hl.exec_cmd("wl-paste --type text --watch cliphist store")
              hl.exec_cmd("wl-paste --type image --watch cliphist store")
              ${optionalString (attrByPath [ "wayland" "hyprpaper" "enable" ] false config) ''hl.exec_cmd("hyprpaper")''}
              ${optionalString (attrByPath [ "wayland" "hyprlock" "enable" ] false config) ''hl.exec_cmd("hyprlock")''}
              ${optionalString (attrByPath [ "wayland" "waybar" "enable" ] false config) ''hl.exec_cmd("waybar")''}
            end
          '')
        ];
      }
    ];
  };

in
{
  imports = [
    ../../hosts/${hostName}/hyprland.nix
  ];
  options.wayland.hyprland = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable Hyprland";
    };
    settings = mkOption {
      type = types.attrs;
      default = {};
      description = "Host-specific Hyprland attribute settings";
    };
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      configType = "lua";
      settings = recursiveUpdate baseSettings cfg.settings // {
        # recursiveUpdate merges sets, but it overwrites lists.
        # So we manually concatenate the important lists:
        on = baseSettings.on ++ (cfg.settings.on or []);
        bind = (baseSettings.bind or []) ++ (cfg.settings.bind or []);
        window_rule = (baseSettings.window_rule or []) ++ (cfg.settings.window_rule or []);
        workspace_rule = (baseSettings.workspace_rule or []) ++ (cfg.settings.workspace_rule or []);
	      monitor =  (baseSettings.monitor or []) ++ (cfg.settings.monitor or []);
	      env =  (baseSettings.env or []) ++ (cfg.settings.env or []);
      };
    };

    home.packages = with pkgs; [ 
      cliphist 
      playerctl 
      pavucontrol
      pulsemixer
      bluetuith
    ];
  };
}
