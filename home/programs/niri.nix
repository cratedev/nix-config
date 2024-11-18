{ lib, config, pkgs, ... }: {
  home.packages = with pkgs; [
    niri swww grim slurp
  ];

  programs.niri = {
    settings = {
      hotkey-overlay.skip-at-startup = true;

      spawn-at-startup = [
        { command = ["swww-daemon"]; }
        { command = ["swww" "img" "../../wallpaper/3.png"]; }
      ];

      prefer-no-csd = true;

      input.keyboard.xkb.layout = "us";
      input.touchpad = {
        tap = true;
        natural-scroll = true;
      };

      layout = {
        gaps = 20;
        center-focused-column = "on-overflow";
        focus-ring = {
          enable = false;
          width = 1;
          active.color = "#fff";
        };
        border = {
          enable = true;
          width = 1;
          active.color = "#344e66";
          inactive.color = "#333333";
        };
        default-column-width.proportion = 0.5;
      };

      screenshot-path = null;

      animations = {
        slowdown = 2.0;
        window-open.easing = {
          duration-ms = 250;
          curve = "ease-out-expo";
        };
        shaders.window-resize = ''
          vec4 resize_color(vec3 coords_curr_geo, vec3 size_curr_geo) {
            // Shader logic
          }
        '';
      };

      window-rules = [
        { matches = [{ app-id = "^org\\.wezfurlong\\.wezterm$"; }]; }
        {
          geometry-corner-radius = { bottom-left = 10.0; bottom-right = 10.0; top-left = 10.0; top-right = 10.0; };
          clip-to-geometry = true;
        }
        { matches = [{ app-id = "^clipse$"; }]; block-out-from = "screen-capture"; }
      ];

      binds = with config.lib.niri.actions; let
        sh = spawn "sh" "-c";
      in {
        "Mod+Shift+Slash".action = show-hotkey-overlay;

        "Mod+Return".action = spawn "foot" "-e" "zellij" "attach" "--create" "main";
        "Mod+D".action = spawn "rofi" "-show" "drun" "-theme" ".config/rofi/launchers/type-1/style-6.rasi";

        "Mod+Q".action = close-window;

        "Mod+Left".action = focus-column-left;
        "Mod+Down".action = focus-window-down;
        "Mod+Up".action = focus-window-up;
        "Mod+Right".action = focus-column-right;

        "Mod+Shift+Left".action = move-column-left;
        "Mod+Shift+Down".action = move-window-down;
        "Mod+Shift+Up".action = move-window-up;
        "Mod+Shift+Right".action = move-column-right;

        "Mod+Home".action = focus-column-first;
        "Mod+End".action = focus-column-last;
        "Mod+Shift+Home".action = move-column-to-first;
        "Mod+Shift+End".action = move-column-to-last;

        "Mod+Page_Down".action = focus-workspace-down;
        "Mod+Page_Up".action = focus-workspace-up;
        "Mod+Shift+Page_Down".action = move-column-to-workspace-down;
        "Mod+Shift+Page_Up".action = move-column-to-workspace-up;

        "Mod+1".action = focus-workspace 1;
        "Mod+2".action = focus-workspace 2;
        "Mod+3".action = focus-workspace 3;
        "Mod+4".action = focus-workspace 4;
        "Mod+5".action = focus-workspace 5;
        "Mod+6".action = focus-workspace 6;
        "Mod+7".action = focus-workspace 7;
        "Mod+8".action = focus-workspace 8;
        "Mod+9".action = focus-workspace 9;

        "Mod+Shift+1".action = move-column-to-workspace 1;
        "Mod+Shift+2".action = move-column-to-workspace 2;
        "Mod+Shift+3".action = move-column-to-workspace 3;
        "Mod+Shift+4".action = move-column-to-workspace 4;
        "Mod+Shift+5".action = move-column-to-workspace 5;
        "Mod+Shift+6".action = move-column-to-workspace 6;
        "Mod+Shift+7".action = move-column-to-workspace 7;
        "Mod+Shift+8".action = move-column-to-workspace 8;
        "Mod+Shift+9".action = move-column-to-workspace 9;

        "Mod+Minus".action = set-column-width "-10%";
        "Mod+Equal".action = set-column-width "+10%";

        "Print".action = screenshot;
        "Mod+I".action = sh ''grim -g "$(slurp)" /home/matt/images/screenshots/$(date +%y.%m.%d-%H:%M:%S).png'';
        "Mod+Shift+E".action = quit;

        "XF86AudioMicMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";
        "XF86AudioRaiseVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+";
        "XF86AudioLowerVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-";
        "XF86MonBrightnessUp".action = spawn (lib.getExe pkgs.brightnessctl) "s" "+5%";
        "XF86MonBrightnessDown".action = spawn (lib.getExe pkgs.brightnessctl) "s" "5%-";
      };
    };
  };
}
