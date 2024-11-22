{ config, pkgs, ... }:

{
  services.jellyfin = {
    enable = true;

    # Optional: Configure storage for Jellyfin data (logs, database, etc.)
    dataDir = "/var/lib/jellyfin";
    cacheDir = "/var/cache/jellyfin";
    logDir = "/var/log/jellyfin";
  };

  networking.firewall.allowedTCPPorts = [ 8096 ];  # Allow Jellyfin's default port
  # Uncomment if you enable HTTPS in Jellyfin:
  # networking.firewall.allowedTCPPorts = [ 8096 8920 ];
}
