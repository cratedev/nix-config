{...}: let
  username = "matt";
in {
  nix = {
    optimise.automatic = true;
    optimise.dates = ["03:45"];
    settings = {
      trusted-users = [username];
      experimental-features = ["nix-command" "flakes" "impure-derivations" "ca-derivations"];
      substituters = ["https://cache.nixos.org"];
      trusted-public-keys = ["cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="];
      builders-use-substitutes = true;
    };
  };

  # Garbage Collection

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Time zone and locale
}
