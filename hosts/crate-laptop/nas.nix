{ config, pkgs, ... }:

{
  # Enable OCI container support
virtualisation.oci-containers = {

    containers = {
      komodo-core = {
        image = "ghcr.io/mbecker20/komodo:latest";
        ports = [ "9120:9120" ];
        environmentFiles = [ "/etc/docker/komodo/compose.env" ];
        environment = {
          POSTGRES_HOST = "komodo-postgres";
          POSTGRES_PORT = "5432";
          POSTGRES_USER = "admin";
          POSTGRES_PASSWORD = "admin";
          POSTGRES_DB = "komodo";

          PASSKEY = "a_random_passkey";

          KOMODO_TITLE = "Komodo";
          KOMODO_FIRST_SERVER = "https://komodo-periphery:8120";
          KOMODO_DISABLE_CONFIRM_DIALOG = "false";

          KOMODO_PASSKEY = "a_random_passkey";
          KOMODO_WEBHOOK_SECRET = "a_random_secret";
          KOMODO_JWT_SECRET = "a_random_jwt_secret";

          KOMODO_LOCAL_AUTH = "true";
          KOMODO_DISABLE_USER_REGISTRATION = "false";
          KOMODO_ENABLE_NEW_USERS = "false";
          KOMODO_DISABLE_NON_ADMIN_CREATE = "false";
          KOMODO_TRANSPARENT_MODE = "false";
        };
        volumes = [
          "/appdata/komodo/:/data"
        ];
      };
      postgres = {
        image = "docker.io/library/postgres:latest";
        environmentFiles = [ "/etc/docker/komodo/compose.env" ];
        environment = {
          POSTGRES_USER = "admin";
          POSTGRES_PASSWORD = "admin";
          POSTGRES_DB = "komodo";
        };
        volumes = [
          "/appdata/komodo/postgres:/var/lib/postgresql/data"
        ];
      };
      ferret = {
        image = "ghcr.io/ferretdb/ferretdb";
        environmentFiles = [ "/etc/docker/komodo/compose.env" ];
        environment = {
          FERRETDB_POSTGRESQL_URL = "postgres://postgres:5432/komodo";
        };
      };
      periphery = {
        image = "ghcr.io/mbecker20/periphery:latest";
        environmentFiles = [ "/etc/docker/komodo/compose.env" ];
        volumes = [
          "/var/run/podman/podman.sock:/var/run/docker.sock"
          "/proc:/proc"
          "/appdata/komodo/ssl-certs:/etc/komodo/ssl"
          "/appdata/komodo/repos:/etc/komodo/repos"
          "/appdata/komodo/stacks:/etc/komodo/stacks"
        ];
      };
    };
  };

   environment.etc."docker/komodo/compose.env".source = ./docker/komodo/compose.env;
}