{
  programs = {
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
