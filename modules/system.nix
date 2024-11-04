{
  pkgs,
  lib,
  ...
}: let
  username = "matt";
in {
  # ============================= User related =============================
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.matt = {
    isNormalUser = true;
    description = "matt";
    extraGroups = ["networkmanager" "wheel" "podman"];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIItETI5nQ1tNxHQ7S7dpDodTU1aT6cPe66+jeS3el9Ac matt@crate-laptop"
    ];
    shell = pkgs.fish;
  };

  # Stylix
  stylix = {
    enable = true;
    autoEnable = true;
    polarity = "dark";
    fonts.sizes = {applications = 10;};
    # dracula, nord, ayu-mirage, da-one-ocean, harmonic16-dark
    base16Scheme = "${pkgs.base16-schemes}/share/themes/da-one-ocean.yaml";
    image = ../wallpaper/3.png;
  };

  # Optimise store
  nix = {
    optimise.automatic = true;
    optimise.dates = ["03:45"];
    settings = {
      trusted-users = [username];
      # enable flakes globally
      experimental-features = ["nix-command" "flakes"];
      substituters = ["https://cache.nixos.org"];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
      builders-use-substitutes = true;
    };
  };

  # do garbage collection weekly to keep disk usage low
  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 7d";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  fonts = {
    packages = with pkgs; [
      font-awesome
      material-design-icons
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      (nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono"];})
    ];
    enableDefaultPackages = false;
    fontconfig.defaultFonts = {
      serif = ["Noto Serif" "Noto Color Emoji"];
      sansSerif = ["Noto Sans" "Noto Color Emoji"];
      monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
      emoji = ["Noto Color Emoji"];
    };
  };

  hardware = {bluetooth.enable = true;};
  security = {polkit.enable = true;};

  ##### SERVICES #####
  services = {
    teamviewer.enable = true;
    nixos-cli.enable = true;
    printing.enable = false;
    power-profiles-daemon.enable = true;
    dbus.packages = [pkgs.gcr];
    geoclue2.enable = true;
    blueman.enable = true;
    gnome.gnome-keyring.enable = true;
    udev.packages = with pkgs; [gnome-settings-daemon];

    ##### SDDM won't build because neatvnc
    #    displayManager.sddm = {
    #      enable = true;
    #      wayland.enable = true;
    #      theme = "catppuccin-mocha";
    #      package = pkgs.sddm;
    #    };

    greetd = {
      enable = true;
      settings = rec {
        default_session = {
          command = "${pkgs.niri}/bin/niri-session";
          user = "matt";
        };
      };
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
        PermitRootLogin = "no"; # disable root login
        PasswordAuthentication = false; # disable password login
      };
      openFirewall = true;
    };
    ##### END SERVICES #####
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-wlr
    ];
    config.common.default = "*";
  };

  # Programs
  programs = {
    ssh.startAgent = true;
    dconf.enable = true;
    hyprland.enable = false;
    niri.enable = true;
    fish.enable = true;
    partition-manager.enable = true;
  };

  environment.systemPackages = [
    pkgs.nixd
    pkgs.cargo
    pkgs.rustc
    pkgs.meson
    pkgs.ncurses
    pkgs.vim
    pkgs.wget
    pkgs.curl
    pkgs.sysstat
    pkgs.lm_sensors
    pkgs.xfce.thunar
    pkgs.xfce.tumbler
    pkgs.whois
    pkgs.busybox
    pkgs.xdg-desktop-portal-hyprland
    pkgs.xdg-desktop-portal-wlr
    (pkgs.catppuccin-sddm.override {
      flavor = "mocha";
      font = "Noto Sans";
      fontSize = "9";
    })
    pkgs.cachix
    (pkgs.callPackage ../home/programs/rofi-custom.nix {})

    ##### PACKAGES FOR NAS #####
    #    pkgs.mergerfs
    #    pkgs.dive
    #    pkgs.podman-tui     // The packages shouldn't be here.
    #    pkgs.podman-compose // In the future, they should go in the
    #    pkgs.docker-compose // Server config
    ##### END PACKAGES FOR NAS #####
  ];
}
