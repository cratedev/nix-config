{ config, pkgs, ... }:

{
  # Enable Prowlarr service
  services.prowlarr = {
    enable = true;

    # Set the data directory where Prowlarr will store its configuration and data files
    dataDir = "/appdata/prowlarr";
  };

  # Ensure the directory exists with appropriate permissions
  systemd.tmpfiles.rules = [
    "d /appdata/prowlarr 0755 prowlarr prowlarr -"
  ];

  # Optionally set firewall rules (if needed)
  networking.firewall.allowedTCPPorts = [ 9696 ];  # Default port for Prowlarr web UI

  # Ensure that the system user for Prowlarr exists
  users.users.prowlarr = {
    isSystemUser = true;
    home = "/var/lib/prowlarr";
  };
}
