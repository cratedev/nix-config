{ pkgs, ... }: let
  # Grouped packages for better readability and maintainability
  utilities = with pkgs; [
    cliphist wl-clipboard-rs
    zip unzip p7zip
    ripgrep libnotify xdg-utils
    fzf ncdu libsecret brightnessctl
    gowall immich-cli
  ];

  filesystemTools = with pkgs; [
    e2fsprogs xfsprogs
  ];

  devTools = with pkgs; [
    nodejs
    nodePackages.npm
    nodePackages.pnpm
    yarn
  ];

  apps = with pkgs; [
    obsidian
    fuzzel
    (discord.override { withVencord = true; })
    networkmanagerapplet
  ];

in {
  home.packages = utilities ++ filesystemTools ++ devTools ++ apps;

  # Uncomment lines for optional programs
  # ++ [ pkgs.hyprpanel pkgs.teamviewer zed-editor ];

  # Program-specific configurations
  programs.spotify-player.enable = true;
  xdg.configFile."spotify-player".source = ./dots/spotify-player;

  programs.ncspot.enable = true;
  xdg.configFile."rofi".source = ./dots/rofi;

  programs = {
    tmux.enable = true;
    vscode.enable = true;
    btop.enable = true; # Modern replacement for htop/nmon
    eza.enable = true;  # Modern replacement for ls
    jq.enable = true;   # Command-line JSON processor
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
