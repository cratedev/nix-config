{ config, pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
        cockpit                       # Cockpit main package
        libvirt                       # Libvirt library for virtualization
        qemu                          # Virtualization backend
        virt-manager                  # Optional: GUI for managing VMs
        udisks2                       # For storage management in Cockpit
        NetworkManager                # For network management
    ];
    # Enable udisks2 for managing storage devices
    services.udisks2.enable = true;

    # Optional: Enable storage pooling support for LVM and related tools
    environment.systemPackages = with pkgs; [
        lvm2                          # Logical Volume Manager tools
    ];

    services.cockpit = {
        enable = true;
        port = 9090;
        settings = {
            WebService = {
                AllowUnencrypted = true;
            };
        };
    };

    virtualisation.libvirtd = {
        enable = true;
        qemuPackage = pkgs.qemu;       # Use QEMU for virtualization
        extraConfig = ''
            unix_sock_group = "libvirt"
            unix_sock_rw_perms = "0770"
        '';                            # Allow group-based socket access
    };
}