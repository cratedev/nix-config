{
  config,
  pkgs,
  ...
}: let
  waybarConfig = {
    layer = "top";
    position = "left";
    height = 32;
    exclusive = true;
    passthrough = false;
    "gtk-layer-shell" = true;
    "modules-left" = [
      "group/launcher"
      "cpu"
      "memory"
      "temperature"
      "group/themes"
      "custom/weather"
    ];
    "modules-center" = ["hyprland/workspaces"];
    "modules-right" = [
      "pulseaudio/slider"
      "pulseaudio#audio"
      "clock#calender"
      "clock"
      "group/power"
    ];

    # Group Launchers
    "group/launcher" = {
      orientation = "vertical";
      drawer = {
        "transition-duration" = 500;
        "children-class" = "not-power";
        "transition-left-to-right" = true;
        "click-to-reveal" = true;
      };
      modules = ["custom/launcher" "tray"];
    };

    "custom/launcher" = {
      format = "";
      tooltip = false;
    };

    tray = {
      "icon-size" = 15;
      spacing = 7;
    };

    cpu = {
      interval = 1;
      format = "{usage:02}%";
      rotate = 90;
    };

    memory = {
      states = {
        c = 90;
        h = 75;
        m = 30;
      };
      interval = 30;
      format = "󰾆";
      "format-m" = "󰾅";
      "format-h" = "󰓅";
      "format-c" = "";
      "max-length" = 10;
      tooltip = true;
      "tooltip-format" = "{percentage}%\n{used:0.1f}GB/{total:0.1f}GB";
    };

    temperature = {
      format = "{temperatureC}°C";
      interval = 2;
      rotate = 90;
    };

    "custom/dots" = {
      format = "";
      tooltip = false;
      rotate = 90;
    };

    "custom/updates" = {
      exec = "~/.config/hypr/scripts/systemupdate.sh";
      "return-type" = "json";
      format = "{}";
      interval = 3600;
      tooltip = true;
      rotate = 90;
    };

    "custom/weather" = {
      format = "{}";
      tooltip = true;
      interval = 600;
      exec = "~/.local/bin/wttrbar --location patna --custom-indicator {FeelsLikeC}°C";
      "return-type" = "json";
      rotate = 90;
    };

    "group/themes" = {
      orientation = "vertical";
      modules = ["custom/theme-switcher"];
    };

    "custom/theme-switcher" = {
      format = "󰬁󰫵󰫲󱎥󰫲󱎤";
      "tooltip-format" = "Switch Themes";
      "on-click" = "~/.config/hypr/scripts/themeswitcher.sh";
      rotate = 90;
    };

    "hyprland/workspaces" = {
      format = "{icon}";
      "format-icons" = {
        "1" = "󰸶";
        "2" = "󰸶";
        "3" = "󰸶";
        "4" = "󰸶";
        "5" = "󰸶";
        "6" = "󰸶";
        "7" = "󰸶";
        default = "󰸶";
        urgent = "";
      };
      "persistent-workspaces" = {
        "*" = 5;
        "HDMI-A-1" = 6;
      };
    };

    "wlr/taskbar" = {
      format = "{icon}";
      "icon-size" = 16;
      "icon-theme" = "Tela-circle-dracula";
      spacing = 0;
      "tooltip-format" = "{title}";
      "on-click" = "activate";
      "on-click-middle" = "close";
      "ignore-list" = ["Alacritty"];
      "app_ids-mapping" = {
        firefoxdeveloperedition = "firefox-developer-edition";
      };
    };

    "pulseaudio/slider" = {
      min = 0;
      max = 100;
      orientation = "vertical";
    };

    "clock#calender" = {
      format = "{:%d·%m·%y}";
      tooltip = false;
      rotate = 90;
    };

    clock = {
      interval = 1;
      format = "\n{:%H\n%M}";
      tooltip = false;
    };

    "group/power" = {
      orientation = "vertical";
      drawer = {
        "transition-duration" = 500;
        "children-class" = "not-power";
        "transition-left-to-right" = false;
        "click-to-reveal" = true;
      };
      modules = ["custom/power" "custom/quit" "custom/reboot"];
    };

    "custom/power" = {
      format = "⏻";
      tooltip = false;
    };

    "custom/reboot" = {
      format = "󰬙";
      "tooltip-format" = "Reboot-baby";
      "on-click" = "reboot";
    };

    "custom/quit" = {
      format = "󰬓";
      "tooltip-format" = "Log-out";
      "on-click" = "hyprctl dispatch exit";
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
}
