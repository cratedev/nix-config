{ inputs, pkgs, ... }:
{
  nixpkgs.overlays = [
#    inputs.hyprpanel.overlay

# Rofi?

    (self: super:
    {
      rofi-wayland = super.rofi-wayland.overrideAttrs (oldAttrs: rec {
        src = super.fetchFromGitHub {
          owner = "Ibonn";
          repo = "rofi";
          rev = "142e78071cbd7ddc2228cc707a583e081ec3bdf2";
          sha256 = "sha256-erdWUek1dKps8GFfBcg2vLK7W7hat+zMpr+ef4fPqEo=";
        };
      });
    })
  ];
}
