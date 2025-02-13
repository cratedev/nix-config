{
  pkgs,
  lib,
  config,
  ...
}: let
  # Define reusable variables
  username = "matt";
  timezone = "America/Toronto";
  locale = "en_US.UTF-8";
  stylixTheme = "da-one-ocean"; #darkmoss ayu-mirage da-one-gray horizon-dark tokyo-city-terminal-dark

  # Define the path to the shared authorized_keys file
  sharedAuthorizedKeys = builtins.readFile ./ssh/authorized_keys;
in {
  # ============================= User Related =============================
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = ["networkmanager" "wheel" "docker" "podman" "libvirt"];
    openssh.authorizedKeys.keys = lib.splitString "\n" sharedAuthorizedKeys;
    shell = pkgs.nushell;
  };

  users.groups.libvirt = {};

  # ============================= Stylix =============================
  stylix = {
    enable = true;
    autoEnable = true;
    polarity = "dark";
    fonts.sizes = {applications = 10;};
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${stylixTheme}.yaml";
    #    image = config.lib.stylix.pixel "base0A";
    image = ../wallpaper/5.jpg;
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
  fonts = {
    packages = with pkgs; [
      font-awesome
      material-design-icons
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      fira-code
    ];
    enableDefaultPackages = false;
    fontconfig.defaultFonts = {
      serif = ["Noto Serif" "Noto Color Emoji"];
      sansSerif = ["Noto Sans" "Noto Color Emoji"];
      monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
      emoji = ["Noto Color Emoji"];
    };
  };

  # ============================= Hardware =============================
  hardware = {bluetooth.enable = false;};
  security = {polkit.enable = true;};

  # ============================= Services =============================
  services = {
    tailscale = {
      enable = true;
      useRoutingFeatures = "client";
      extraSetFlags = [
        "--accept-routes"
        "--accept-dns"
        "--exit-node-allow-lan-access"
        "--exit-node=100.114.171.64"
      ];
    };
    resolved.enable = true;
    teamviewer.enable = true;
    printing.enable = false;
    power-profiles-daemon.enable = true;
    dbus.packages = [pkgs.gcr];
    geoclue2.enable = true;
    blueman.enable = true;
    gnome.gnome-keyring.enable = true;
    udev.packages = with pkgs; [gnome-settings-daemon];
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "catppuccin-mocha";
      package = pkgs.kdePackages.sddm;
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    openssh = {
      enable = true;
      settings = {
        X11Forwarding = true;
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
      knownHosts = import ./ssh/knownHosts;
      openFirewall = true;
    };
  };

  # ============================= XDG Portals =============================
  xdg.portal = {
    enable = lib.mkForce false;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
    ];
    config.common.default = "*";
  };

  # ============================= Programs =============================
  programs = {
    ssh.startAgent = true;
    dconf.enable = true;
    niri.enable = true;
    fish.enable = true;
    #    xwayland.enable = true;
    _1password.enable = true;
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = ["matt"];
    };
  };

  # ============================= System Packages =============================
  environment.systemPackages = with pkgs; [
    nh
    sshfs
    nixd
    niri
    python3
    ncurses
    vim
    wget
    curl
    busybox
    cachix
    (catppuccin-sddm.override {
      flavor = "mocha";
      font = "Noto Sans";
      fontSize = "9";
    })
    rofi-wayland
  ];

  # ============================= Session Variables =============================
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.FLAKE = "/home/${username}/nix-config";

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
