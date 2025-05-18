{...}: {
  imports = [
    ../../modules/system.nix
    ../../modules/user.nix
    ../../modules/generic.nix
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
    hostName = "crate-laptop"; # Define your hostname.
    networkmanager.enable = true;
    firewall = {
      enable = false;
      checkReversePath = "loose";
    };
  };

  hardware.bluetooth.enable = false;
  security = {
    polkit.enable = true;
    pam.services.sddm.text = ''
      auth      sufficient   pam_fprintd.so
      auth      required     pam_unix.so try_first_pass
      account   required     pam_unix.so
      session   required     pam_unix.so
    '';
  };

  fileSystems."/home/matt/unraid-ssh" = {
    device = "root@10.0.0.10:/mnt";
    fsType = "fuse.sshfs";
    options = [
      "nodev"
      "noatime"
      "allow_other"
      "IdentityFile=/home/matt/.ssh/id_ed25519"
    ];
  };
  system.stateVersion = "24.05";
}
