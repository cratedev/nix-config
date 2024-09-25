{ config, pkgs, lib, ... }:

{
  networking.firewall.enable = false; # Disable firewall for simplicity

  containers = {
    sonarr1 = {
      autoStart = true;
      config = { config, pkgs, ... }: {
        networking.hostName = "sonarr1";
        networking.useDHCP = false;
        networking.interfaces.eth0.ipv4.addresses = [{ address = "127.0.0.1"; prefixLength = 24; }];
        services.sonarr = {
          enable = true;
          dataDir = "/var/lib/sonarr1";
          openFirewall = true;
          # Custom settings for this instance if needed
        };
        # Optional: expose the service on a different port if needed
        networking.firewall.allowedTCPPorts = [ 8989 ]; # Sonarr default web port
      };
    };

    sonarr2 = {
      autoStart = true;
      config = { config, pkgs, ... }: {
        networking.hostName = "sonarr2";
        networking.useDHCP = false;
        networking.interfaces.eth0.ipv4.addresses = [{ address = "127.0.0.1"; prefixLength = 24; }];
        services.sonarr = {
          enable = true;
          dataDir = "/var/lib/sonarr2";
          openFirewall = true;
          # Custom settings for this instance if needed
        };
        # Optional: expose this instance on a different port
        networking.firewall.allowedTCPPorts = [ 8990 ]; # Another port for second instance
      };
    };
  };
}
