{
  config,
  pkgs,
  lib,
  ...
}: let
  waybarConfig = {
    include = [
      "\${HOME}/.config/niri/waybar/modules/modules-dual-tone.jsonc"
      "\${HOME}/.config/niri/waybar/modules/modules-custom.jsonc"
      "\${HOME}/.config/niri/waybar/modules/modules-groups.jsonc"
    ];

    layer = "top";
    position = "bottom";
    mod = "dock";
    exclusive = true;
    passthrough = false;
    "gtk-layer-shell" = true;
    reload_style_on_change = true;
    height = 20;
    "margin-top" = 0;
    "margin-left" = 0;
    "margin-right" = 0;

    "modules-left" = [
      "custom/launch_rofi"
      "niri/window"
      "idle_inhibitor"
      "custom/nightlight"
      #      "custom/clipboard_icon"
      #      "custom/clipboard"
      "group/system"
      #      "power-profiles-daemon"
      "mpris"
    ];

    "modules-center" = [
      "niri/workspaces"
    ];

    "modules-right" = [
      #      "tray"
      "custom/pulseaudio_icon"
      "pulseaudio"
      "custom/pulse_mic_icon"
      "pulseaudio#microphone"
      "custom/updater_icon"
      "custom/updater"
      "battery"
      "backlight"
      "group/network"
      "custom/notify_icon"
      "custom/notify"
      "clock"
      "group/power"
    ];

    "niri/workspaces" = {
      "disable-scroll" = true;
      "all-outputs" = true;
      "on-click" = "activate";
      "on-scroll-up" = "hyprctl dispatch workspace e-1";
      "on-scroll-down" = "hyprctl dispatch workspace e+1";
      format = "{icon}";
      "format-icons" = {
        default = "";
      };
      "persistent-workspaces" = {
        "1" = [];
        "2" = [];
        "3" = [];
      };
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
  home.file.".config/niri/waybar/modules/modules-dual-tone.jsonc".source = ./modules/modules-dual-tone.jsonc;
  home.file.".config/niri/waybar/modules/modules-custom.jsonc".source = ./modules/modules-custom.jsonc;
  home.file.".config/niri/waybar/modules/modules-groups.jsonc".source = ./modules/modules-groups.jsonc;
}
