{
  pkgs,
  lib,
  ...
}: let
  # Define reusable variables
  username = "matt";
  timezone = "America/Toronto";
  locale = "en_US.UTF-8";
  # Define the path to the shared authorized_keys file
  #  sharedAuthorizedKeys = builtins.readFile ./ssh/authorized_keys;
in {
  # ============================= User Related =============================
  #  users.users.${username} = {
  #    isNormalUser = true;
  #    description = username;
  #    extraGroups = ["networkmanager" "wheel" "docker" "podman" "libvirt"];
  #    openssh.authorizedKeys.keys = lib.splitString "\n" sharedAuthorizedKeys;
  #    shell = pkgs.nushell;
  #  };

  #  users.groups.libvirt = {};

  # ============================= Stylix =============================

  # ============================= Nix Optimizations =============================
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
  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 7d";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Time zone and locale
  time.timeZone = timezone;
  i18n.defaultLocale = locale;
  i18n.extraLocaleSettings = lib.mkDefault {
    LC_ADDRESS = locale;
    LC_IDENTIFICATION = locale;
    LC_MEASUREMENT = locale;
    LC_MONETARY = locale;
    LC_NAME = locale;
    LC_NUMERIC = locale;
    LC_PAPER = locale;
    LC_TELEPHONE = locale;
    LC_TIME = locale;
  };
}
