{pkgs, ...}: let
  stylixTheme = "da-one-ocean"; #darkmoss ayu-mirage da-one-gray horizon-dark tokyo-city-terminal-dark
in {
  stylix = {
    enable = true;
    autoEnable = true;
    polarity = "dark";
    fonts.sizes = {applications = 10;};
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${stylixTheme}.yaml";
    #    image = config.lib.stylix.pixel "base0A";
    #    image = ../wallpaper/12.png;
  };
}
