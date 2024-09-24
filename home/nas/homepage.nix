{ pkgs, config, ... }:
{
    services.homepage = {
        enable = true;
        settings = {
            server = {
                port = 8800;
                bind_address = "::1";
            };
        };
    };
}
