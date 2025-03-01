{
  config,
  pkgs,
  ...
}: let
  waybarConfig = {
    layer = "top";
    position = "top";
    modules-left = ["custom/logo" "clock" "disk" "memory" "cpu" "temperature"];
    modules-center = ["niri/workspaces"];
    modules-right = ["pulseaudio/slider" "battery" "network"];
    reload_style_on_change = true;

    "custom/logo" = {
      format = "<span font='14px'>  </span>";
      tooltip = false;
      on-click = "swaync-client -t";
    };

    network = {
      format-wifi = "";
      format-ethernet = "";
      format-disconnected = "";
      tooltip-format-disconnected = "Error";
      tooltip-format-wifi = "{essid} ({signalStrength}%) ";
      tooltip-format-ethernet = "{ifname} 🖧 ";
      on-click = "ghostty -e nmtui";
    };

    pulseaudio = {
      scroll-step = 5;
      max-volume = 150;
      format = " {volume}%";
      format-bluetooth = "󱄡 {volume}%";
      on-click = "pavucontrol";
      tooltip = false;
    };

    clock = {
      format = "{:%I:%M %p}";
      tooltip = true;
      tooltip-format = "<small>{:%D}</small>";
      calendar-weeks-pos = "right";
    };

    disk = {
      interval = 30;
      format = " {percentage_used}%";
      path = "/";
    };

    memory = {
      format = " {percentage}%";
    };

    cpu = {
      interval = 1;
      format = " {usage}%";
    };

    temperature = {
      format = " {temperatureC}°C";
      format-critical = " {temperatureC}°C";
      interval = 1;
      critical-threshold = 80;
    };

    "niri/workspaces" = {
      format = "<span font='14px'>{icon}</span>";
      format-icons = {
        "1" = "";
        "2" = "";
        "3" = " ";
        "4" = "󱝿";
        "5" = "";
      };
      persistent-workspaces = {"*" = [1 2 3 4 5];};
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
