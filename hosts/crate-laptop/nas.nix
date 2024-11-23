{ config, pkgs, ... }:

{
  # Enable OCI container support
virtualisation.oci-containers = {

    containers = {
      komodo = {
        image = "ghcr.io/mbecker20/komodo:latest";
        ports = [ "9120:9120" ];
        environmentFiles = [ "/etc/docker/komodo/compose.env" ];
        volumes = [
          "/appdata/komodo/:/data"
        ];
      };
      komodo-postgres = {
        image = "docker.io/library/postgres:latest";
        ports = [ "5432:5432" ];
        environmentFiles = [ "/etc/docker/komodo/compose.env" ];
        environment = {
          POSTGRES_USER = "${DB_USERNAME}";
          POSTGRES_PASSWORD = "${DB_PASSWORD}";
          POSTGRES_DB = "${KOMODO_DATABASE_DB_NAME:-komodo}";
          POSTGRES_DB_HOST = "localhost"
        };
        volumes = [
          "/appdata/komodo/postgres:/var/lib/postgresql/data"
        ];
      };
      komodo-ferret = {
        image = "ghcr.io/ferretdb/ferretdb";
        environmentFiles = [ "/etc/docker/komodo/compose.env" ];
        environment = {
          FERRETDB_POSTGRESQL_URL = "postgres://postgres:5432/${KOMODO_DATABASE_DB_NAME:-komodo}";
        };
      };
      komodo-periphery = {
        image = "ghcr.io/mbecker20/periphery:${COMPOSE_KOMODO_IMAGE_TAG:-latest}";
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
   environment.etc."docker/komodo/compose.yaml".source = ./docker/komodo/compose.yaml;
}