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
    fuzzel
    networkmanagerapplet
  ];

  programs = {
    btop.enable = true;
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
