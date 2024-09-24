{ pkgs, ... }:
{
  imports = [
#    ./automation.nix
#    ./mediaserver.nix
#    ./auth.nix
#    ./cloudflare.nix
#    ./crowdsec.nix
#    ./financial.nix
#    ./homepage.nix
#    ./immich.nix
#    ./jellystat.nix
#    ./paperless.nix
    ./search.nix
#    ./tesla.nix
#    ./tools.nix
#    ./proxy.nix
    ./vaultwarden.nix
  ];

  environment.systemPackages = with pkgs; [
    searxng
    jellyfin
    sonarr
    radarr
    prowlarr
    traefik
    vaultwarden
    paperless-ngx
  ];
}
