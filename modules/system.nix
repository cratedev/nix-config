{
  pkgs,
  lib,
  ...
}: let
  # Define reusable variables
  username = "matt";
  timezone = "America/Toronto";
  locale = "en_US.UTF-8";
  stylixTheme = "da-one-ocean"; #darkmoss ayu-mirage da-one-gray horizon-dark tokyo-city-terminal-dark
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
  stylix = {
    enable = true;
    autoEnable = true;
    polarity = "dark";
    fonts.sizes = {applications = 10;};
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${stylixTheme}.yaml";
    #    image = config.lib.stylix.pixel "base0A";
    #    image = ../wallpaper/12.png;
  };

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

  # ============================= Fonts =============================
  # ============================= Hardware =============================

  # ============================= XDG Portals =============================
  xdg.portal = {
    enable = lib.mkForce false;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      #      xdg-desktop-portal-hyprland
    ];
    config.common.default = "*";
  };

  # ============================= Session Variables =============================
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
  # ============================= SSHFS =========================================
  #  fileSystems."/home/matt/unraid-ssh" = {
  #device = "root@10.0.0.10:/mnt";
  #fsType = "fuse.sshfs";
  #options = [
  #"nodev"
  #"noatime"
  #"allow_other"
  #"IdentityFile=/home/matt/.ssh/id_ed25519"
  #];
  #};
}
