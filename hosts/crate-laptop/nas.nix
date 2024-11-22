{ config, pkgs, ... }:

{
  # Enable Docker
  virtualisation.docker = {
    enable = true;
#    extraOptions = "--bip=10.0.1.100/24"; # Example custom bridge network
  };

  # Install Docker Compose
  environment.systemPackages = with pkgs; [
    docker-compose
  ];

  # Define a systemd service to manage the Docker Compose file
  systemd.services.komodo-postgres = {
    description = "Run Docker Compose for Komodo Postgres";
    after = [ "docker.service" ];
    requires = [ "docker.service" ];

    serviceConfig = {
      ExecStart = "${pkgs.docker-compose}/bin/docker-compose -f /etc/docker/komodo/compose.yaml up --env-file /etc/docker/komodo/compose.env";
      ExecStop = "${pkgs.docker-compose}/bin/docker-compose -f /etc/docker/komodo/compose.yaml down";
      Restart = "always";
      WorkingDirectory = "/etc/docker/komodo";
    };

    wantedBy = [ "multi-user.target" ];
  };
  # Ensure the docker-compose file is available at the correct location
  environment.etc."docker/komodo/compose.yaml".source = 
    builtins.fetchurl {
      url = "https://raw.githubusercontent.com/cratedev/nix-nas/refs/heads/master/komodo/compose.yaml";
      sha256 = "1kfw39k3yrkwhjy540hw9gplyahmdi2gxcfkn1pc76nkkrj050z8"; # Replace with the actual hash of the file.
    };
  environment.etc."docker/komodo/compose.env".source =
    builtins.fetchurl {
      url = "https://raw.githubusercontent.com/cratedev/nix-nas/refs/heads/master/komodo/compose.env";
      sha256 = "0rdvxlkifssg2h11hr8zamsy2z1v7m4yaimyjz4gaiira69sssys"; # Replace with the actual hash of the file.
    };

}
