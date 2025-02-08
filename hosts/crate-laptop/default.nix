{...}: {
  imports = [
    ../../home/programs/x86_64-specific.nix
    ../../modules/system.nix
    ./hardware-configuration.nix
  ];

  # Where we're going, we don't need channels
  nix.channel.enable = false;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "crate-laptop"; # Define your hostname.
    networkmanager.enable = true;
    firewall.enable = false;
    firewall.checkReversePath = "loose";
  };

  # ============================= SSHFS =========================================
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
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
