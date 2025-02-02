{
  pkgs,
  lib,
  ...
}: {
  home.packages = [pkgs.zellij];

  # Foot configuration simplified
  programs.foot = {
    enable = false;
    settings = {
      main = {
        font = lib.mkForce "monospace:size=10"; # Set font directly
        letter-spacing = "0";
        pad = "8x8";
      };
    };
  };
}
