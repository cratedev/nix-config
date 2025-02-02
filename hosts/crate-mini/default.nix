{...}: {
  imports = [
    ../../modules/system.nix
    ../../modules/nas/default.nix
    ./apple-silicon-support
    ./hardware-configuration.nix
  ];

  # Where we're going, we don't need channels
  nix.channel.enable = false;

  # Specify path to peripheral firmware files.
  hardware.asahi.peripheralFirmwareDirectory = ./firmware;
  # Or disable extraction and management of them completely.
  # hardware.asahi.extractPeripheralFirmware = false;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  networking.hostName = "crate-mini"; # Define your hostname.
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
