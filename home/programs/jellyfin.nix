{ config, pkgs, ... }:

{
  services.jellyfin = {
    enable = true;
    # Optional: Specify data directories
    mediaDirectories = [
      {
        path = "/home/matt/media";
        recursive = true;  # Scan subdirectories
      }
    ];

    # Optional: Configure storage for Jellyfin data (logs, database, etc.)
    dataDir = "/var/lib/jellyfin";
    cacheDir = "/var/cache/jellyfin";
    logDir = "/var/log/jellyfin";

    # Optional: Additional Jellyfin options
    extraOptions = "--ffmpeg=/path/to/custom/ffmpeg";  # Customize ffmpeg if needed
  };

  networking.firewall.allowedTCPPorts = [ 8096 ];  # Allow Jellyfin's default port
  # Uncomment if you enable HTTPS in Jellyfin:
  # networking.firewall.allowedTCPPorts = [ 8096 8920 ];
}
