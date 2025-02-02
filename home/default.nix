{...}: {
  imports = [
    ./programs
    ./shell
    ./dots
  ];

  home = {
    username = "matt";
    homeDirectory = "/home/matt";

    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "24.05";
  };

  # Let Home Manager install and manage itself.
  home.enableNixpkgsReleaseCheck = false;

  programs = {
    nix-index = {
      enable = true;
      enableFishIntegration = true;
    };
    home-manager.enable = true;
    tmux.enable = true;
  };
}
