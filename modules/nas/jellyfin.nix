{ config, pkgs, ... }:

{
  services.jellyfin = {
    enable = true;

    # Optional: Configure storage for Jellyfin data (logs, database, etc.)
    dataDir = "/appdata/jellyfin";
    cacheDir = "/appdata/jellyfin/cache";
    logDir = "/appdata/jellyfin/logs";
  };

#  networking.firewall.allowedTCPPorts = [ 8096 ];  # Allow Jellyfin's default port
  # Uncomment if you enable HTTPS in Jellyfin:
  # networking.firewall.allowedTCPPorts = [ 8096 8920 ];
}
