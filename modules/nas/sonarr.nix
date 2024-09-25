{ config, pkgs, ... }:

{
  # Enable Sonarr service
  services.sonarr = {
    enable = true;

    # Set the data directory where Sonarr will store its configuration and data files
    dataDir = "/appdata/sonarr";
  };

  # Ensure the directory exists with appropriate permissions
  systemd.tmpfiles.rules = [
    "d /appdata/sonarr 0755 sonarr sonarr -"
  ];

  # Optionally set firewall rules (if needed)
  networking.firewall.allowedTCPPorts = [ 8989 ];

  # Example: Ensure that the directory has the right owner/group and permissions
  users.users.sonarr = {
    isSystemUser = true;
    home = "/appdata/sonarr";
  };

  # Ensure the filesystem where the /appdata/sonarr is located is mounted (if using a separate volume)
#  fileSystems."/appdata" = {
#    device = "/dev/sdxY";  # Change to your device
#    fsType = "ext4";       # Or whatever filesystem you are using
#  };
}
