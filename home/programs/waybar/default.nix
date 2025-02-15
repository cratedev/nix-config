{...}: {
  programs.waybar = {
    enable = true;
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
      "custom/dot-alt"
      "group/user-container"
      "custom/dot-fade"
      "group/music-controller"
      "network#up"
      "network#down"
      "custom/right-arrw"
      "custom/cava"
      "custom/right-arrw"
      "hyprland/workspaces"
    ];

    modules-center = [];

    modules-right = [
      "custom/weather"
      "custom/dot"
      "custom/cpuinfo"
      "custom/dot"
      "memory"
      "custom/dot"
      "network"
      "custom/left-arrw"
      "group/system-container"
      "custom/dot-alt"
      "group/clock-container"
    ];

    "group/launcher" = {
      orientation = "horizontal";
      drawer = {
        transition-duration = 500;
        children-class = "launcher,";
        transition-left-to-right = true;
        click-to-reveal = true;
      };
      modules = ["custom/launcher" "tray"];
    };

    "custom/launcher" = {
      format = "  ";
      tooltip = false;
    };

    tray = {
      icon-size = 20;
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
      format = "\uF04A";
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
        Playing = "<span>\uF04C</span>";
        Paused = "<span>\uF04B</span>";
        Stopped = "<span>\uF04B</span>";
      };
    };

    "custom/playerctl-forward" = {
      format = "\uF04E";
      tooltip = false;
      on-click = "playerctl next";
      on-scroll-up = "playerctl volume .05+";
      on-scroll-down = "playerctl volume .05-";
    };

    "group/user-container" = {
      orientation = "horizontal";
      modules = ["load" "custom/theme-switcher"];
    };

    load = {
      interval = 10;
      format = " Load  {load1}";
      max-length = 15;
    };

    "custom/theme-switcher" = {
      format = "󰬁󰫵󰫲󱎥󰫲󱎤";
      tooltip-format = "Switch Themes";
      on-click = "~/.config/hypr/scripts/themeswitcher.sh";
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

    "custom/cava" = {
      format = {};
      tooltip = false;
      exec = "~/.config/hypr/scripts/cava.sh";
    };

    "hyprland/workspaces" = {
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

    "custom/weather" = {
      format = "󰬁󰫲󰫺󰫽 {}°C";
      tooltip = true;
      interval = 600;
      exec = "~/.local/bin/wttrbar --location patna --custom-indicator {temp_C}";
      return-type = "json";
    };

    "clock" = {
      timezone = "Asia/Kolkata";
      format = "\uDB82\uDD54  {:%I:%M %p}";
      format-alt = "  {:%d·%m·%y}";
      tooltip-format = "<tt>{calendar}</tt>";
    };
  };
}
