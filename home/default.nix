{...}: {
  imports = [
    ./shell
    ./dots
    ./modules
  ];

  home = {
    username = "matt";
    homeDirectory = "/home/matt";
    enableNixpkgsReleaseCheck = false;
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "24.05";
  };

  stylix.targets = {
    waybar.enable = false;
    firefox = {
      profileNames = ["matt"];
    };
  };

  programs = {
    home-manager.enable = true;
  };
}
