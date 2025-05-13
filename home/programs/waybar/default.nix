{ config, pkgs, lib, ... }:
{
  programs.waybar = {
    enable = true;
    settings = lib.importJSON ./config.jsonc;
    style = builtins.readFile ./style.css;
  };

  home.file.".config/waybar/colors.css".source = ./colors.css;
}

