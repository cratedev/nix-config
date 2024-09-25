{ config, pkgs, ... }:

{
  # Enable Prowlarr service
  services.prowlarr = {
    enable = true;
  };

  # Use systemd's service customization to bind the default /var/lib/prowlarr directory to /appdata/prowlarr
  systemd.services.prowlarr = {
    after = [ "network.target" ];  # Ensure it starts after the network is up

    serviceConfig = {
      # Bind the /var/lib/prowlarr directory to /appdata/prowlarr
      BindPaths = [ "/appdata/prowlarr:/var/lib/prowlarr" ];
    };
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
    group = "prowlarr";
    home = "/var/lib/prowlarr";
  };
  users.groups.prowlarr = {};
}
