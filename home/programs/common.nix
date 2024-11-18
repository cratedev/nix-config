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
    obsidian
    fuzzel
    brightnessctl
    ncdu
    libsecret
    nodejs
    nodePackages.npm
    nodePackages.pnpm
    yarn
    # pkgs.hyprpanel
    (discord.override {withVencord = true;})
    e2fsprogs
    xfsprogs
    networkmanagerapplet
    #zed-editor
    gowall
    immich-cli
    # pkgs.teamviewer
  ];

  # Manage incompatible .configs
  programs.spotify-player.enable = true;
  xdg.configFile."spotify-player".source = ./dots/spotify-player;
  programs.ncspot.enable = true;
  xdg.configFile."rofi".source = ./dots/rofi;

  programs = {
    tmux.enable = true;
    vscode.enable = true;
    btop.enable = true; # replacement of htop/nmon
    eza.enable = true; # A modern replacement for ‘ls’
    jq.enable = true; # A lightweight and flexible command-line JSON processor
    aria2.enable = true;
    nix-index = {
      enable = true;
      enableFishIntegration = true;
    };
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
