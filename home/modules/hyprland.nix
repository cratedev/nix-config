{pkgs, ...}: {
  home.packages = with pkgs; [
    adwaita-icon-theme
    swww
    grim
    slurp
    gtk3
  ];

  programs.kitty.enable = true;
  home.sessionVariables.NIXOS_OZONE_WL = "1";

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$mod" = "SUPER";

      monitor = [
        "eDP-1,preferred,auto,1" # Use scale=1
      ];

      env = [
        "XCURSOR_THEME,Adwaita"
        "XCURSOR_SIZE,12"
        "GTK_THEME,Orchis-Purple"
        "ICON_THEME,kora"
      ];

      exec-once = [
        "swww-daemon"
        "swww img /home/matt/nix-config/wallpaper/12.png"
        "waybar"
        "1password --ozone-platform-hint=auto"
        "nm-applet"
        "blueman-applet"
        "dunst"
        "udiskie"
        "wl-paste --watch cliphist store"
      ];

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = true;
          tap-to-click = true;
        };
      };

      general = {
        gaps_in = 10;
        gaps_out = 10;
        border_size = 1;
      };

      animations = {
        enabled = true;
        bezier = "easeOutExpo, 0.19, 1.0, 0.22, 1.0";
        animation = "windows, 1, 7, easeOutExpo";
      };

      decoration = {
        rounding = 6;
      };

      bind =
        [
          "$mod, RETURN, exec, ghostty -e zellij attach --create main"
          "$mod, D, exec, rofi -show drun -theme ~/.config/rofi/launchers/type-1/style-6.rasi"
          "$mod, E, exec, nemo"
          "$mod, Q, killactive"
          "$mod, V, togglefloating"
          "$mod, F, fullscreen"
          "$mod, SPACE, exec, rofi -show run"
          "$mod, P, pseudo"
          "$mod, J, movefocus, l"
          "$mod, K, movefocus, u"
          "$mod, H, movefocus, r"
          "$mod, L, movefocus, d"
          "$mod SHIFT, J, swapwindow, l"
          "$mod SHIFT, K, swapwindow, u"
          "$mod SHIFT, H, swapwindow, r"
          "$mod SHIFT, L, swapwindow, d"
          "$mod, TAB, workspace, e+1"
          "$mod SHIFT, TAB, workspace, e-1"
          "$mod, S, togglesplit"
          "$mod SHIFT, E, exit"
          "$mod ALT, R, exec, hyprctl reload"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
          builtins.concatLists (builtins.genList (
              i: let
                ws = i + 1;
              in [
                "$mod, code:1${toString i}, workspace, ${toString ws}"
                "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            )
            9)
        );
    };
  };
}
