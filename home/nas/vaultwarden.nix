{ pkgs, config, ... }:
{
    services.vaultwarden = {
        enable = true;
        config = {
            ROCKET_ADDRESS = "::1"; # default to localhost
            ROCKET_PORT = 8523;
        };
    };
}
