{ config, pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
        libvirt                       # Libvirt library for virtualization
        qemu                          # Virtualization backend
        virt-manager                  # Optional: GUI for managing VMs
        udisks2                       # For storage management in Cockpit
        networkmanager                # For network management
        lvm2                          # Logical Volume Manager tools

    ];
    # Enable udisks2 for managing storage devices
    services.udisks2.enable = true;

    services.cockpit = {
        enable = true;
        port = 9090;
        settings = {
            WebService = {
                AllowUnencrypted = true;
            };
        };
    };

# Enable libvirt and QEMU for Virtual Machine management
virtualisation.libvirtd.enable = true;
#virtualisation.qemu.enable = true;

# Enable Podman for container management
virtualisation.docker.enable = true;

# Enable Network Manager
networking.networkmanager.enable = true;
}