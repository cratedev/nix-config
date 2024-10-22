{ inputs, pkgs, ... }:
{
  nixpkgs.overlays = [
#    inputs.hyprpanel.overlay
  ];
}
