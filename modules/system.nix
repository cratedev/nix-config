let
  username = "matt";
in {
  nix = {
    channel.enable = false;
    optimise = {
      automatic = true;
      dates = ["03:45"];
    };
    settings = {
      trusted-users = [username];
      experimental-features = ["nix-command" "flakes" "impure-derivations" "ca-derivations"];
      substituters = ["https://cache.nixos.org"];
      trusted-public-keys = ["cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="];
      builders-use-substitutes = true;
    };
  };

  nixpkgs.config.allowUnfree = true;
}
