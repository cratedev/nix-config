{
  pkgs,
  inputs,
  ...
}: let
  utilities = with pkgs; [
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
    #    immich-cli
    navi
    calibre
    #swaybg
    #matugen
    lazygit
    nautilus
  ];

  filesystemTools = with pkgs; [
    e2fsprogs
    xfsprogs
  ];

  devTools = with pkgs; [
    nodejs
    nodePackages.npm
    nodePackages.pnpm
    yarn
    python312Packages.pip
  ];

  apps = with pkgs;
    [
      obsidian
      fuzzel
      networkmanagerapplet
    ]
    ++ (
      if pkgs.stdenv.system == "x86_64-linux"
      then [
        inputs.zen-browser.packages.x86_64-linux.default
        (discord.override {withVencord = true;})
      ]
      else []
    );
in {
  home.packages = utilities ++ filesystemTools ++ devTools ++ apps;

  xdg.configFile = {
    "spotify-player".source = ../dots/spotify-player;
    "rofi".source = ../dots/rofi;
  };

  programs = {
    spotify-player.enable = true;
    ncspot.enable = true;
    tmux.enable = true;
    vscode.enable = false;
    btop.enable = true;
    eza.enable = false;
    jq.enable = true;
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
