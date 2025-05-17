let
  username = "matt";
in {
  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      NH_FLAKE = "/home/${username}/nix-config";
    };
    etc = {
      "1password/custom_allowed_browsers" = {
        text = ''
          		.zen-wrapped
          		.zen-beta-wrapp
          zen
          zen-beta
        '';
        mode = "0755";
      };
    };
  };
}
