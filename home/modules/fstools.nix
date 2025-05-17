{pkgs, ...}: {
  home.packages = with pkgs; [
    cliphist
    wl-clipboard-rs
    zip
    unzip
    p7zip
    ripgrep
    libnotify
    xdg-utils
    fzf
    ncdu
    libsecret
    brightnessctl
    gowall
    navi
    lazygit
    nautilus
    binutils
  ];
}
