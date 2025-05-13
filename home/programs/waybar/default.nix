{
  config,
  pkgs,
  lib,
  ...
}: let
  waybarConfig = {
    layer = "top";
    position = "top";
    height = 28;
    spacing = 6;
    margin = "5 5 0 5";
    modules-left = [
      "custom/launcher"
      "hyprland/workspaces"
      "hyprland/submap"
      "hyprland/window"
    ];
    modules-center = [];
    modules-right = [
      "pulseaudio#volume"
      "battery"
      "clock"
      "tray"
    ];

    "custom/launcher" = {
      format = "";
      on-click = "wofi --show drun";
      tooltip = false;
    };

    "hyprland/window" = {
      format = "{}";
      separate-outputs = true;
    };

    "hyprland/workspaces" = {
      format = "{name}";
      all-outputs = true;
      on-click = "activate";
      sort-by-number = true;
      format-icons = {
        active = "";
        default = "";
      };
    };

    "pulseaudio#volume" = {
      format = " {volume}%";
      tooltip = false;
      on-click = "pavucontrol";
    };

    battery = {
      states = {
        good = 80;
        warning = 30;
        critical = 15;
      };
      format = "{capacity}%  ";
      format-charging = "{capacity}% ";
      format-plugged = "{capacity}% ";
      format-alt = "{time}  ";
      tooltip = false;
    };

    clock = {
      format = "{:%H:%M }";
      tooltip = true;
      tooltip-format = "{:%A, %d %B %Y}";
    };

    tray = {
      spacing = 10;
    };
  };
in {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = waybarConfig;
    };
    style = builtins.readFile ./style.css;
  };
  home.file.".config/waybar/style/mocha.css".source = ./mocha.css;
}
