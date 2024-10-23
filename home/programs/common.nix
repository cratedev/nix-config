{ lib, pkgs, inputs, ... }:
{
  home.packages = [
    pkgs.cliphist
    pkgs.wl-clipboard-rs
    pkgs.zip
    pkgs.unzip
    pkgs.p7zip
    pkgs.ripgrep
    pkgs.libnotify
    pkgs.xdg-utils
    pkgs.fzf
    pkgs.slurp
    pkgs.grim
    pkgs.obsidian
#    pkgs.rofi-wayland
    pkgs.rofi-1.7.5-dev
    pkgs.fuzzel
    pkgs.brightnessctl
    pkgs.gnome-bluetooth
    pkgs.ncdu
    pkgs.libsecret
    pkgs.nodejs
    pkgs.nodePackages.npm
    pkgs.nodePackages.pnpm
    pkgs.yarn
    pkgs.vlc pkgs.mpv
    pkgs.zellij
#    pkgs.hyprpanel
    pkgs.firefox-beta-bin
    pkgs.bitwarden-desktop
    (pkgs.discord.override {withVencord = true;})
    pkgs.zed-editor
    pkgs.pamixer
    pkgs.ytfzf
#    pkgs.hyprlock
#    pkgs.compose2nix
#    pkgs.tigervnc
    pkgs.e2fsprogs
    pkgs.xfsprogs
#    pkgs.protonvpn-gui
    pkgs.networkmanagerapplet
    pkgs.teamviewer
    pkgs.niri
#    pkgs.waybar
    pkgs.swww
  ];

  # Manage incompatible .configs
  programs.spotify-player.enable = true; xdg.configFile."spotify-player".source = ./dots/spotify-player;
  programs.ncspot.enable = true; xdg.configFile."ncspot/credentials.json".source = ./dots/ncspot/credentials.json;
  xdg.configFile."rofi".source = ./dots/rofi;

  programs = {
    nix-index = {
      enable = true;
      enableFishIntegration = true;
    };
    tmux.enable = true;
    vscode.enable = true;
    btop.enable = true; # replacement of htop/nmon
    eza.enable = true; # A modern replacement for ‘ls’
    jq.enable = true; # A lightweight and flexible command-line JSON processor
    aria2.enable = true;
    skim = {
      enable = true;
      enableFishIntegration = true;
      defaultCommand = "rg --files --hidden";
      changeDirWidgetOptions = [
        "--preview 'exa --icons --git --color always -T -L 3 {} | head -200'"
        "--exact"
      ];
    };
  };
}
