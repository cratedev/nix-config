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
    ./hardware-configuration.nix
  ];
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "crate-desktop";
    networkmanager.enable = true;
  };

  system.stateVersion = "24.05";
}
