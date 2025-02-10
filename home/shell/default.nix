{pkgs, ...}: {
  imports = [
    ./terminals.nix
    ./fish.nix
    ./zellij
    ./nu.nix
  ];

  # Environment Variables: Group related variables together
  home.sessionVariables = {
    EDITOR = "nano";
    BROWSER = "firefox";
    TERMINAL = "ghostty";
    DELTA_PAGER = "less -R";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
  };

  # Shell Aliases: Define common aliases concisely
  home.shellAliases = {
    k = "kubectl";
    ls = "eza -l";
    immup = "immich upload -r -a $HOME/images/screenshots";
    tu = "sudo tailscale up";
    td = "sudo tailscale down";
  };
}
