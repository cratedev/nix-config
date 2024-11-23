{ config, pkgs, ... }:

{
  # Enable OCI container support
virtualisation.oci-containers = {

    containers = {
      komodo = {
        # Define the container image
        image = "ghcr.io/mbecker20/komodo:latest"; # Replace with the actual image

        # Define ports to expose
        ports = [ "9120:9120" ]; # Adjust port mappings as needed

        # Define environment variables
        environmentFiles = [ "/etc/docker/komodo/compose.env" ];

        # Mount any required volumes
        volumes = [
          "/appdata/komodo/:/data" # Adjust for your volumes
        ];
#	autoStart = true;
      };
    };
  };

   environment.etc."docker/komodo/compose.env".source = ./docker/komodo/compose.env;
   environment.etc."docker/komodo/compose.yaml".source - ./docker/komodo/compose.yaml;

  # Ensure environment file is available
#  environment.etc."docker/komodo/compose.env".source =
#    builtins.fetchurl {
#      url = "https://raw.githubusercontent.com/cratedev/nix-nas/refs/heads/master/komodo/compose.env";
#      sha256 = "0rdvxlkifssg2h11hr8zamsy2z1v7m4yaimyjz4gaiira69sssys"; # Replace with the actual hash
#    };

#  environment.etc."docker/komodo/compose.yaml".source =
#    builtins.fetchurl {
#      url = "https://raw.githubusercontent.com/cratedev/nix-nas/refs/heads/master/komodo/compose.yaml";
#      sha256 = "1kfw39k3yrkwhjy540hw9gplyahmdi2gxcfkn1pc76nkkrj050z8"; # Replace with the actual hash
#    };

}
