{ config, ... }: let
#  d = config.xdg.dataHome;
#  c = config.xdg.configHome;
#  cache = config.xdg.cacheHome;
in {
  imports = [
    ./terminals.nix
    ./fish.nix
    ./zellij
  ];

  # add environment variables
  home.sessionVariables = {
    # set default applications
    EDITOR = "nano";
    BROWSER = "firefox";
    TERMINAL = "foot";
    NIXOS_OZONE_WL = "1";
    # enable scrolling in git diff
    DELTA_PAGER = "less -R";

    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
  };

  home.shellAliases = {
    k = "kubectl";
    ls = "eza -l";
  };
}
