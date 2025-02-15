programs.waybar = {
  enable = true;
  settings = [{
		style = builtins.readFile ./style.css;
    layer = "top";
    position = "left";
    mod = "dock";
    height = 28;
    exclusive = true;
    passthrough = false;
    gtk-layer-shell = true;

		#modules-left = [ "group/launcher" "cpu" "memory" "temperature" "group/themes" "custom/weather" ];
		#modules-center = [ "hyprland/workspaces" ];
		modules-right = [ "pulseaudio/slider" "pulseaudio#audio" "clock#calender" "clock" "group/power" ];

    "group/launcher" = {
      orientation = "vertical";
      drawer = {
        transition-duration = 500;
        children-class = "not-power,";
        transition-left-to-right = true;
        click-to-reveal = true;
      };
      modules = [ "custom/launcher" "tray" ];
    };

    "custom/launcher" = {
      format = "\uf303";
      tooltip = false;
    };

    tray = {
      icon-size = 15;
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
      format = "\uf8c6";
      format-m = "\uf8c5";
      format-h = "\uf415";
      format-c = "\uf061";
      max-length = 10;
      tooltip = true;
      tooltip-format = "{percentage}%\n{used:0.1f}GB/{total:0.1f}GB";
    };

    temperature = {
      format = "{temperatureC}°C";
      interval = 2;
      rotate = 90;
    };

    "custom/weather" = {
      format = "{}";
      tooltip = true;
      interval = 600;
      exec = "~/.local/bin/wttrbar --location patna --custom-indicator {FeelsLikeC}°C";
      return-type = "json";
      rotate = 90;
    };

    "group/themes" = {
      orientation = "vertical";
      modules = [ "custom/theme-switcher" ];
    };

    "custom/theme-switcher" = {
      format = "\uf02d";
      tooltip-format = "Switch Themes";
      on-click = "~/.config/hypr/scripts/themeswitcher.sh";
      rotate = 90;
    };

    "hyprland/workspaces" = {
      format = "{icon}";
      format-icons = {
        "1" = "\uf074";
        "2" = "\uf074";
        "3" = "\uf074";
        "4" = "\uf074";
        "5" = "\uf074";
        "6" = "\uf074";
        "7" = "\uf074";
        default = "\uf074";
        urgent = "\uf492";
      };
      persistent-workspaces = {
        "*" = 5;
        "HDMI-A-1" = 6;
      };
    };

    "wlr/taskbar" = {
      format = "{icon}";
      icon-size = 16;
      icon-theme = "Tela-circle-dracula";
      spacing = 0;
      tooltip-format = "{title}";
      on-click = "activate";
      on-click-middle = "close";
      ignore-list = [ "Alacritty" ];
      app_ids-mapping = {
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
        transition-duration = 500;
        children-class = "not-power";
        transition-left-to-right = false;
        click-to-reveal = true;
      };
      modules = [ "custom/power" "custom/quit" "custom/reboot" ];
    };

    "custom/power" = {
      format = "⏻";
      tooltip = false;
    };

    "custom/reboot" = {
      format = "\uf011";
      tooltip-format = "Reboot-baby";
      on-click = "reboot";
    };

    "custom/quit" = {
      format = "\uf08b";
      tooltip-format = "Log-out";
      on-click = "hyprctl dispatch exit";
    };
  }];
};

