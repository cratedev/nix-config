{ config, pkgs, ... }:

{
  # Enable Docker service
  services.docker = {
    enable = true;
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
      ExecStart = "${pkgs.docker-compose}/bin/docker-compose -f /etc/docker/komodo/postgres.compose.yaml up";
      ExecStop = "${pkgs.docker-compose}/bin/docker-compose -f /etc/docker/komodo/postgres.compose.yaml down";
      Restart = "always";
      WorkingDirectory = "/etc/docker/komodo";
    };

    wantedBy = [ "multi-user.target" ];
  };

  # Ensure the docker-compose file is available at the correct location
  environment.etc."docker/komodo/postgres.compose.yaml".source = 
    builtins.fetchurl {
      url = "https://raw.githubusercontent.com/mbecker20/komodo/main/compose/postgres.compose.yaml";
      sha256 = "0rr1s1dj85kbdd1cba2hjr192gwrlw2nxnz3xf3z141wwma78x73"; # Replace with the actual hash of the file.
    };
}
