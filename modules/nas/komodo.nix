{...}: {
  virtualisation.oci-containers.containers.komodo = {
    image = "ghcr.io/mbecker20/komodo:latest"; # Replace with a specific tag if needed
    extraOptions = "--restart unless-stopped"; # Ensures the container restarts on failure.
    volumes = [
      "/appdata/komodo:/app/data" # Adjust as needed for persistent storage.
    ];
    ports = [
      "8080:8080" # Expose the port, adjust if the app uses a different one.
    ];
    environment = {
      KOMODO_CONFIG = "/app/data/config.json"; # Example, modify based on the app's requirements.
    };
  };
}
