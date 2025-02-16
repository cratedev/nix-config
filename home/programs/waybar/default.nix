{pkgs, ...}: {
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    style = builtins.readFile ./style.css;

    settings = [
      {
        layer = "top";
        position = "top";
        height = 40;
        margin-top = 0;
        margin-left = 0;
        margin-bottom = 0;
        margin-right = 0;
        spacing = 0;

        modules-left = [
          "group/launcher"
          "group/music-controller"
          "network#up"
          "network#down"
          "niri/workspaces"
        ];

        modules-center = [];

        modules-right = [
          "custom/cpuinfo"
          "memory"
          "network"
          "group/clock-container"
        ];

        # Module definitions
        "group/launcher" = {
          orientation = "horizontal";
          drawer = {
            transition-duration = 500;
            children-class = "launcher";
            transition-left-to-right = true;
            click-to-reveal = true;
          };
          modules = ["custom/launcher" "tray"];
        };

        "custom/launcher" = {
          format = "  ";
          tooltip = false;
        };

        tray = {
          icon-size = 12;
          spacing = 7;
        };

        "group/music-controller" = {
          orientation = "horizontal";
          modules = [
            "custom/playerctl-backward"
            "custom/playerctl-play"
            "custom/playerctl-forward"
          ];
        };

        "custom/playerctl-backward" = {
          format = "";
          tooltip = false;
          on-click = "playerctl previous";
          on-scroll-up = "playerctl volume .05+";
          on-scroll-down = "playerctl volume .05-";
        };

        "custom/playerctl-play" = {
          format = "{icon}";
          return-type = "json";
          exec = "playerctl -a metadata --format '{\"text\": \"{{artist}} - {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
          on-click = "playerctl play-pause";
          on-scroll-up = "playerctl volume .05+";
          on-scroll-down = "playerctl volume .05-";
          format-icons = {
            Playing = "<span></span>";
            Paused = "<span></span>";
            Stopped = "<span></span>";
          };
        };

        "custom/playerctl-forward" = {
          format = "";
          tooltip = false;
          on-click = "playerctl next";
          on-scroll-up = "playerctl volume .05+";
          on-scroll-down = "playerctl volume .05-";
        };

        load = {
          interval = 10;
          format = " Load {load1}";
          max-length = 15;
        };

        "network#up" = {
          format = "{bandwidthUpBytes:>3}";
          tooltip = false;
          interval = 2;
        };

        "network#down" = {
          format = "{bandwidthDownBytes:>3}";
          tooltip = false;
          interval = 2;
        };

        "niri/workspaces" = {
          all-outputs = false;
          active-only = false;
          on-click = "activate";
          format = "{icon}";
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
          format-icons = {
            "1" = "󰸳";
            "2" = "󰸳";
            "3" = "󰸳";
            "4" = "󰸳";
            "5" = "󰸳";
            "6" = "󰸳";
            "7" = "󰸳";
            "8" = "󰸳";
            "9" = "󰸳";
            "10" = "󰸳";
            urgent = "";
            default = "󰸳";
          };
        };

        "wlr/taskbar" = {
          format = "{icon}";
          icon-size = 12;
          icon-theme = "Tela-circle-dracula";
          spacing = 0;
          tooltip-format = "{title}";
          on-click = "activate";
          on-click-middle = "close";
          ignore-list = ["Alacritty"];
          app_ids-mapping = {
            "firefoxdeveloperedition" = "firefox-developer-edition";
          };
        };

        memory = {
          interval = 30;
          format = "󰫺󰫲󰫺 {used}GB";
          max-length = 14;
          tooltip = true;
          tooltip-format = "   {percentage}%\n {used:0.1f}GB/{total:0.1f}GB \n {swapUsed}GB/{swapTotal}GB";
        };

        "group/system-container" = {
          orientation = "horizontal";
          modules = [
            "group/updates-grp"
            "group/pulseaudio-grp"
            "group/disk-grp"
            "group/redshift-grp"
            "group/cpu-grp"
          ];
        };

        "group/clock-container" = {
          orientation = "horizontal";
          modules = ["clock"];
        };

        clock = {
          timezone = "America/Toronto";
          format = "  {:%I:%M %p}";
          format-alt = "  {:%d·%m·%y}";
          tooltip-format = "<tt>{calendar}</tt>";
        };
      }
    ];
  };
}
