{ lib, config, pkgs, inputs, outputs, system, ... }:
{
    programs.niri = {
#        enable = true;
        settings = {
            spawn-at-startup = [
#                { command = [ "${lib.getExe pkgs.xwayland-satellite-unstable}" ]; }
#                { command = [ "${lib.getExe pkgs.networkmanagerapplet}" ]; }
#                { command = [ "${pkgs.lxqt.lxqt-policykit}/bin/lxqt-policykit-agent" ]; }   # authentication prompts
#                { command = [ "${lib.getExe pkgs.wl-clip-persist} --clipboard primary" ]; } # to fix wl clipboards disappearing
#                (if config.modules.desktop.hypridle.enable then {
#                    command = [ "${lib.getExe config.modules.desktop.hypridle.package}" ];
#                } else null)
            ]; # ++ (map (cmd: { command = [ "sh" "-c" cmd ]; }) config.modules.desktop.execOnStart);

            input = {
            #workspace-auto-back-and-forth = true;
            keyboard.xkb = {
                layout = "us";
#                variant = "workman,";
#                options = "grp:win_space_toggle";
            };

            touchpad = {
                tap = true;
                natural-scroll = true;
                #dwt = true;
            };
        };

        environment = {
          DISPLAY = ":0";
        };

#        prefer-no-csd = true;

        # https://github.com/YaLTeR/niri/wiki/Configuration:-Layout
        layout = {
          gaps = 6;

          center-focused-column = "on-overflow";

          focus-ring = {
            enable = false;
            width = 1;
#            active.color = config.modules.desktop.themes.niri.accent;
#            inactive.color = config.modules.desktop.themes.niri.inactive;
          };

          border = {
            enable = true;
            width = 1;
#            active.color = config.modules.desktop.themes.niri.accent;
#            inactive.color = config.modules.desktop.themes.niri.inactive;
          };
        };

        screenshot-path = null;

        # https://github.com/YaLTeR/niri/wiki/Configuration:-Animations
        animations = {
          shaders.window-resize = ''
            vec4 resize_color(vec3 coords_curr_geo, vec3 size_curr_geo) {
              vec3 coords_next_geo = niri_curr_geo_to_next_geo * coords_curr_geo;

              vec3 coords_stretch = niri_geo_to_tex_next * coords_curr_geo;
              vec3 coords_crop = niri_geo_to_tex_next * coords_next_geo;

              // We can crop if the current window size is smaller than the next window
              // size. One way to tell is by comparing to 1.0 the X and Y scaling
              // coefficients in the current-to-next transformation matrix.
              bool can_crop_by_x = niri_curr_geo_to_next_geo[0][0] <= 1.0;
              bool can_crop_by_y = niri_curr_geo_to_next_geo[1][1] <= 1.0;

              vec3 coords = coords_stretch;
              if (can_crop_by_x)
                coords.x = coords_crop.x;
              if (can_crop_by_y)
                coords.y = coords_crop.y;

              vec4 color = texture2D(niri_tex_next, coords.st);

              // However, when we crop, we also want to crop out anything outside the
              // current geometry. This is because the area of the shader is unspecified
              // and usually bigger than the current geometry, so if we don't fill pixels
              // outside with transparency, the texture will leak out.
              //
              // When stretching, this is not an issue because the area outside will
              // correspond to client-side decoration shadows, which are already supposed
              // to be outside.
              if (can_crop_by_x && (coords_curr_geo.x < 0.0 || 1.0 < coords_curr_geo.x))
                color = vec4(0.0);
              if (can_crop_by_y && (coords_curr_geo.y < 0.0 || 1.0 < coords_curr_geo.y))
                color = vec4(0.0);

              return color;
            }
          '';
        };

        # https://github.com/YaLTeR/niri/wiki/Configuration:-Window-Rules
        window-rules = [
          {
            matches = [{ app-id = "^org\.wezfurlong\.wezterm$"; }];
            default-column-width = {};
          }
          (let
            allCorners = r: { bottom-left = r; bottom-right = r; top-left = r; top-right = r; };
          in {
            geometry-corner-radius = allCorners 10.0;
            clip-to-geometry = true;
          })
          {
            matches = [
              { app-id = "^clipse$"; }
              #{ app-id = "^rofi-rbw$"; }
            ];
            block-out-from = "screen-capture";
          }
        ];

        # https://github.com/YaLTeR/niri/wiki/Configuration:-Key-Bindings
        binds = with config.lib.niri.actions; let
          sh = spawn "sh" "-c";
        in {
          "Mod+Shift+Slash".action = show-hotkey-overlay;

          "Mod+Enter".action = spawn "foot -e zellij attach --create main";
          "Mod+D".action = spawn "fuzzel";

          "Mod+Q".action = close-window;

          "Mod+Left".action  = focus-column-left;
          "Mod+Down".action  = focus-window-down;
          "Mod+Up".action    = focus-window-up;
          "Mod+Right".action = focus-column-right;
          #"Mod+H".action     = focus-column-left;
          #"Mod+J".action     = focus-window-down;
          #"Mod+K".action     = focus-window-up;
          #"Mod+L".action     = focus-column-right;

          "Mod+Shift+Left".action  = move-column-left;
          "Mod+Shift+Down".action  = move-window-down;
          "Mod+Shift+Up".action    = move-window-up;
          "Mod+Shift+Right".action = move-column-right;
          #"Mod+Shift+H".action     = move-column-left;
          #"Mod+Shift+J".action     = move-window-down;
          #"Mod+Shift+K".action     = move-window-up;
          #"Mod+Shift+L".action     = move-column-right;

          # "Mod+J".action     = focus-window-or-workspace-down;
          # "Mod+K".action     = focus-window-or-workspace-up;
          # "Mod+Ctrl+J".action     = move-window-down-or-to-workspace-down;
          # "Mod+Ctrl+K".action     = move-window-up-or-to-workspace-up;

          "Mod+Home".action = focus-column-first;
          "Mod+End".action  = focus-column-last;
          "Mod+Shift+Home".action = move-column-to-first;
          "Mod+Shift+End".action  = move-column-to-last;

          #"Mod+Shift+Left".action  = focus-monitor-left;
          #"Mod+Shift+Down".action  = focus-monitor-down;
          #"Mod+Shift+Up".action    = focus-monitor-up;
          #"Mod+Shift+Right".action = focus-monitor-right;
          #"Mod+Shift+H".action     = focus-monitor-left;
          #"Mod+Shift+J".action     = focus-monitor-down;
          #"Mod+Shift+K".action     = focus-monitor-up;
          #"Mod+Shift+L".action     = focus-monitor-right;

          #"Mod+Shift+Ctrl+Left".action  = move-column-to-monitor-left;
          #"Mod+Shift+Ctrl+Down".action  = move-column-to-monitor-down;
          #"Mod+Shift+Ctrl+Up".action    = move-column-to-monitor-up;
          #"Mod+Shift+Ctrl+Right".action = move-column-to-monitor-right;
          #"Mod+Shift+Ctrl+H".action     = move-column-to-monitor-left;
          #"Mod+Shift+Ctrl+J".action     = move-column-to-monitor-down;
          #"Mod+Shift+Ctrl+K".action     = move-column-to-monitor-up;
          #"Mod+Shift+Ctrl+L".action     = move-column-to-monitor-right;

          "Mod+Page_Down".action      = focus-workspace-down;
          "Mod+Page_Up".action        = focus-workspace-up;
          #"Mod+U".action              = focus-workspace-down;
          #"Mod+I".action              = focus-workspace-up;
          "Mod+Shift+Page_Down".action = move-column-to-workspace-down;
          "Mod+Shift+Page_Up".action   = move-column-to-workspace-up;
          #"Mod+Ctrl+U".action         = move-column-to-workspace-down;
          #"Mod+Ctrl+I".action         = move-column-to-workspace-up;

          "Mod+Ctrl+Page_Down".action = move-workspace-down;
          "Mod+Ctrl+Page_Up".action   = move-workspace-up;
          #"Mod+Shift+U".action         = move-workspace-down;
          #"Mod+Shift+I".action         = move-workspace-up;

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

          "Mod+Comma".action  = consume-window-into-column;
          "Mod+Period".action = expel-window-from-column;

          "Mod+BracketLeft".action  = consume-or-expel-window-left;
          "Mod+BracketRight".action = consume-or-expel-window-right;

          "Mod+R".action = switch-preset-column-width;
          "Mod+Shift+R".action = switch-preset-window-height;
          "Mod+Ctrl+R".action = reset-window-height;
          "Mod+F".action = maximize-column;
          "Mod+Shift+F".action = fullscreen-window;
          "Mod+C".action = center-column;

          "Mod+Minus".action = set-column-width "-10%";
          "Mod+Equal".action = set-column-width "+10%";

          "Mod+Shift+Minus".action = set-window-height "-10%";
          "Mod+Shift+Equal".action = set-window-height "+10%";

          "Print".action = screenshot;
          "Ctrl+Print".action = screenshot-screen;
          "Alt+Print".action = screenshot-window;

          "Mod+Shift+E".action = quit;

          "XF86AudioMicMute".action     = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";
          "XF86AudioMicMute".allow-when-locked = true;

          "XF86Launch1".action = sh "${lib.getExe pkgs.rofi-rbw-wayland} -a copy -t password --clear-after 20";
          "XF86AudioRaiseVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+";
          "XF86AudioRaiseVolume".allow-when-locked = true;
          "XF86AudioLowerVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-";
          "XF86AudioLowerVolume".allow-when-locked = true;
          "XF86AudioMute".action        = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
          "XF86AudioMute".allow-when-locked = true;
          "XF86MonBrightnessUp".action = spawn (lib.getExe pkgs.brightnessctl) "s" "+5%";
          "XF86MonBrightnessUp".allow-when-locked = true;
          "XF86MonBrightnessDown".action = spawn (lib.getExe pkgs.brightnessctl) "s" "5%-";
          "XF86MonBrightnessDown".allow-when-locked = true;
        };
      };
    };
}