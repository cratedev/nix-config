{pkgs, ...}: {
  services = {
    tailscale = {
      enable = false;
      useRoutingFeatures = "client";
      extraSetFlags = [
        "--accept-routes"
        "--accept-dns"
        "--exit-node-allow-lan-access"
        "--exit-node=100.114.171.64"
      ];
    };
    resolved.enable = true;
    teamviewer.enable = true;
    printing.enable = false;
    power-profiles-daemon.enable = true;
    dbus.packages = [pkgs.gcr];
    geoclue2.enable = true;
    blueman.enable = true;
    gnome.gnome-keyring.enable = true;
    udev.packages = with pkgs; [gnome-settings-daemon];

    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "catppuccin-mocha";
      package = pkgs.kdePackages.sddm;
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    openssh = {
      enable = true;
      settings = {
        X11Forwarding = true;
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
      knownHosts = import ./ssh/knownHosts;
      openFirewall = true;
    };

    fprintd = {
      enable = true;
      package = pkgs.fprintd-tod;
      tod.enable = true;
      tod.driver = pkgs.libfprint-2-tod1-broadcom;
    };

    xserver = {
      enable = false;
      desktopManager.gnome.enable = false;
    };
  };
}
