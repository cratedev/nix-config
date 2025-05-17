{
  lib,
  pkgs,
  ...
}: {
  xdg.portal = {
    enable = lib.mkForce false;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      #      xdg-desktop-portal-hyprland
    ];
    config.common.default = "*";
  };
}
