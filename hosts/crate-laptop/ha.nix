{  
  virtualisation.oci-containers = {
    backend = "docker";
    containers.homeassistant = {
      volumes = [ "/appdata/home-assistant:/config" ];
      environment.TZ = "Europe/London";
      image = "ghcr.io/home-assistant/home-assistant:latest"; # Warning: if the tag does not change, the image will not be updated
      extraOptions = [ 
        "--network=host" 
#        "--device=/dev/ttyACM0:/dev/ttyACM0"  # Example, change this to match your own hardware
      ];
    };
  };
}