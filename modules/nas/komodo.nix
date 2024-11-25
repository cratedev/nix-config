{
  virtualisation.oci-containers = {
    backend = "docker"; # Use Docker as the container backend
    containers = {
      
      komodo-core = {
        image = "ghcr.io/mbecker20/komodo:latest-aarch64"; # Use -aarch64 for ARM support if needed
        extraOptions = [ "--network=proxy" ];
        ports = [ "9120:9120" ];
        dependsOn = [ "komodo-mongo" ];
        environment = {
#          KOMODO_HOST = "https://komodo2.crate.dev"; # CHANGEME
          KOMODO_TITLE = "Komodo";
          KOMODO_ENSURE_SERVER = "http://komodo-periphery:8120";

          # MongoDB
          KOMODO_MONGO_ADDRESS = "komodo-mongo:27017";
          KOMODO_MONGO_USERNAME = "admin";
          KOMODO_MONGO_PASSWORD = "admin";

          # Keys
          KOMODO_PASSKEY = "zz0notsosafe";
          KOMODO_WEBHOOK_SECRET = "zz0notsosafe1";
          KOMODO_JWT_SECRET = "a_random_jwt_secret";

          # Auth & OIDC
          KOMODO_DISABLE_CONFIRM_DIALOG = "true";
          KOMODO_LOCAL_AUTH = "true";
        };
#        labels = {
#          "traefik.enable" = "true";
#          "traefik.http.routers.komodo.rule" = "Host(`komodo.crate.dev`)";
#          "traefik.http.routers.komodo.entrypoints" = "https";
#          "traefik.http.routers.komodo.tls" = "true";
#          "traefik.http.routers.komodo.tls.certresolver" = "cloudflare";
#          "traefik.http.services.komodo.loadBalancer.server.port" = "9120";
#        };
      };

      komodo-periphery = {
        image = "ghcr.io/mbecker20/periphery:latest-aarch64"; # Use -aarch64 for ARM support if needed
	ports = [ "8120:8120" ];
        extraOptions = [ "--network=proxy" ];
        volumes = [
          "/var/run/docker.sock:/var/run/docker.sock"
          "/appdata/komodo/komodo-repos:/etc/komodo/repos"
          "/appdata/komodo/komodo-stacks:/etc/komodo/stacks"
        ];
      };

      komodo-mongo = {
        image = "mongo";
        ports = [ "27017:27017" ];
        extraOptions = [ "--network=proxy" ];
        environment = {
          MONGO_INITDB_ROOT_USERNAME = "admin";
          MONGO_INITDB_ROOT_PASSWORD = "admin";
        };
        volumes = [
          "/appdata/komodo/db-data:/data/db"
          "/appdata/komodo/db-config:/data/configdb"
        ];
      };
    };
  };
}
