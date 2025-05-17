{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    nh
    sshfs
    nixd
    nix-search-cli
    nix-search-tv
    niri
    kitty
    python3
    ncurses
    vim
    wget
    curl
    busybox
    cachix
    (catppuccin-sddm.override {
      flavor = "mocha";
      font = "Noto Sans";
      fontSize = "9";
    })
    rofi-wayland
    xorg.xrandr
    nss
    wineWowPackages.stagingFull
    winetricks
    vulkan-tools
    libpulseaudio
    libGL
    glxinfo
    pciutils
    e2fsprogs
    xfsprogs
  ];
}
