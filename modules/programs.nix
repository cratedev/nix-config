{
  programs = {
    ssh.startAgent = true;
    dconf.enable = true;
    niri.enable = true;
    hyprland.enable = false;
    fish.enable = true;
    xwayland.enable = true;
    _1password.enable = true;
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = ["matt"];
    };
    steam.enable = true;
    zoxide = {
      enable = true;
      flags = ["--cmd cd"];
    };
  };
}
