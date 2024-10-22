{ inputs, pkgs, ... }:
{
  nixpkgs.overlays = [
#    inputs.hyprpanel.overlay

# Rofi?

    (self: super:
    {
      rofi = super.rofi.overrideAttrs (oldAttrs: rec {
        src = super.fetchFromGithub {
          owner = "Ibonn";
          repo = "rofi";
          rev = "142e78071cbd7ddc2228cc707a583e081ec3bdf2";
          sha256 = "142e78071cbd7ddc2228cc707a583e081ec3bdf2";
        };
      });
    })
  ];
}
