{...}: {
  imports = [
    ../../modules/system.nix
    ../../modules/user.nix
    ../../modules/fonts.nix
    ../../modules/services.nix
    ../../modules/programs.nix
    ../../modules/packages.nix
    ../../modules/xdg.nix
    ../../modules/stylix.nix
    ../../modules/env.nix
    ../../modules/garbage.nix
    ./apple-silicon-support
    ./hardware-configuration.nix
  ];

  # Specify path to peripheral firmware files.
  hardware.asahi.peripheralFirmwareDirectory = ./firmware;

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = false;
  };

  networking = {
    hostName = "crate-mini";
    networkmanager.enable = true;
    firewall.enable = false;
  };

  system.stateVersion = "24.05";
}
