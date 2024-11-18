{ pkgs, ... }: {
  imports = [
    ./terminals.nix
    ./fish.nix
    ./zellij
  ];

  # Environment Variables: Group related variables together
  home.sessionVariables = {
    EDITOR = "nano";
    BROWSER = "firefox";
    TERMINAL = "foot";
    DELTA_PAGER = "less -R";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
  };

  # Shell Aliases: Define common aliases concisely
  home.shellAliases = {
    k = "kubectl";
    ls = "eza -l";
    immup = "immich upload -r -a $HOME/images/screenshots";
  };
}
