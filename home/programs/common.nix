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
    pkgs.fish
    pkgs.rofi-wayland
    pkgs.brightnessctl
    pkgs.gnome.gnome-bluetooth
    pkgs.ncdu
    pkgs.libsecret
    pkgs.swaybg
    pkgs.nodejs
    pkgs.nodePackages.npm
    pkgs.nodePackages.pnpm
    pkgs.yarn
    pkgs.vlc pkgs.mpv
    pkgs.zellij
    pkgs.hyprpanel
    pkgs.firefox-beta-bin
    pkgs.bitwarden
    (pkgs.discord.override {withVencord = true;})
    pkgs.zed-editor
    pkgs.pamixer
    pkgs.ytfzf
    pkgs.hyprlock
  ];

  # Manage incompatible .configs
  programs.spotify-player.enable = true; xdg.configFile."spotify-player".source = ./dots/spotify-player;
  programs.ncspot.enable = true; xdg.configFile."ncspot/credentials.json".source = ./dots/ncspot/credentials.json;
#  programs.rofi.enable = true; xdg.configFile."rofi".source = ./dots/rofi;

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
