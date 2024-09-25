{ config, pkgs, ... }:

{
  # Enable radarr service
  services.radarr = {
    enable = true;

    # Set the data directory where radarr will store its configuration and data files
    dataDir = "/appdata/radarr";
  };

  # Ensure the directory exists with appropriate permissions
  systemd.tmpfiles.rules = [
    "d /appdata/radarr 0755 radarr radarr -"
  ];

  # Optionally set firewall rules (if needed)
  networking.firewall.allowedTCPPorts = [ 8989 ];

  # Example: Ensure that the directory has the right owner/group and permissions
  users.users.radarr = {
    isSystemUser = true;
    home = "/appdata/radarr";
  };

  # Ensure the filesystem where the /appdata/radarr is located is mounted (if using a separate volume)
#  fileSystems."/appdata" = {
#    device = "/dev/sdxY";  # Change to your device
#    fsType = "ext4";       # Or whatever filesystem you are using
#  };
}
