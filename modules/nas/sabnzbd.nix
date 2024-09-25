{ config, pkgs, ... }:

{
  # Enable sabnzbd service
  services.sabnzbd = {
    enable = true;

    # Set the data directory where sabnzbd will store its configuration and data files
    dataDir = "/appdata/sabnzbd";
  };

  # Ensure the directory exists with appropriate permissions
  systemd.tmpfiles.rules = [
    "d /appdata/sabnzbd 0755 sabnzbd sabnzbd -"
  ];

  # Optionally set firewall rules (if needed)
  networking.firewall.allowedTCPPorts = [ 8080 ];

  # Example: Ensure that the directory has the right owner/group and permissions
  users.users.sabnzbd = {
    isSystemUser = true;
    home = "/appdata/sabnzbd";
  };

  # Ensure the filesystem where the /appdata/sabnzbd is located is mounted (if using a separate volume)
#  fileSystems."/appdata" = {
#    device = "/dev/sdxY";  # Change to your device
#    fsType = "ext4";       # Or whatever filesystem you are using
#  };
}
