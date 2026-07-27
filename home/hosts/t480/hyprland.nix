{ config, pkgs, vars, lib, ... }:

let 
  lua = lib.generators.mkLuaInline;
  deskmon1 = "LG Electronics LG ULTRAGEAR 201MAUAH4462";
  deskmon2 = "Dell Inc. S2419HGF 4XWK7P2";
in 
{

  imports = [
    ./waybar.nix
    ../../modules/desktop/hypridle.nix
    ../../modules/desktop/hyprshot.nix
    ../../modules/desktop/hyprpolkitagent.nix
  ];
  wayland.hyprland = {
    settings = {
      monitor = [
        {
          output = "desc:${deskmon1}";
          mode = "2560x1440@60";
          position = "0x0";
          scale = 1;
        }
        {
          output = "desc:${deskmon2}";
          mode = "1920x1080@60";
          position = "2560x0";
          scale = 1;
        }
        {
          output = "eDP-1";
          mode = "1920x1080@60";
          position = "4480x0";
          scale = 1;
        }
      ];
      
      on = [
        {
          _args = [
            "hyprland.start"
            (lua /* lua */ ''
              function()
                hl.exec_cmd("hypridle")
                hl.exec_cmd("kdeconnect-indicator")
              end
            '')
          ];
        }
      ];

      bind = [
        {_args = ["PRINT" (lua ''hl.dsp.exec_cmd("hyprshot -z -m region -o ${vars.dir.home}/screenshots/")'')];}
        {_args = ["XF86MonBrightnessUp" (lua ''hl.dsp.exec_cmd("brightnessctl set 5%+")'') {locked = true;}];}
        {_args = ["XF86MonBrightnessDown" (lua ''hl.dsp.exec_cmd("brightnessctl set 5%-")'') {locked = true;}];}
        {_args = ["XF86AudioMicMute" (lua ''hl.dsp.exec_cmd("pamixer --default-source --toggle-mute")'') {locked = true;}];}
      ];

      workspace_rule = [
        {
          workspace = "1";
          monitor = "desc:${deskmon1}";
          default = true;
          persistent = true;
        }
        {
          workspace = "2";
          monitor = "desc:${deskmon1}";
          persistent = true;
        }
        {
          workspace = "3";
          monitor = "desc:${deskmon1}";
          persistent = true;
        }
        {
          workspace = "4";
          monitor = "desc:${deskmon2}";
          default = true;
          persistent = true;
        }
        {
          workspace = "5";
          monitor = "desc:${deskmon2}";
          persistent = true;
        }
        {
          workspace = "6";
          monitor = "desc:${deskmon2}";
          persistent = true;
        }
        {
          workspace = "7";
          monitor = "eDP-1";
          default = true;
          persistent = true;
        }
        {
          workspace = "8";
          monitor = "eDP-1";
          persistent = true;
        }
        {
          workspace = "9";
          monitor = "eDP-1";
          persistent = true;
        }
      ];


      window_rule = [
        {
          match = { class = "code"; };
          opacity = "0.93";
        }
        {
          match = { class = "discord"; };
          opacity = "0.87";
        }
        {
          match = { class = "^org\.telegram\.desktop$"; };
          opacity = "0.87";
        }
        {
          match = { class = "firefox"; };
          opacity = "0.94 0.94 1.00";
        }
        {
          match = { class = "^Proton\.Mail$"; };
          opacity = "0.87";
        }
        {
          match = { class = "kitty"; };
          opacity = "0.80";
        }
      ];
      
      # overriding a base value instead of appending
      #general.gaps_in = 10; 
    };
  };
}
