{pkgs, ...}: {
  imports = [
    ./zellij
    ./nu.nix
    ./ghostty.nix
  ];

  home.packages = [pkgs.zellij];

  # Shell Aliases: Define common aliases concisely
  #  home.shellAliases = {
  #  k = "kubectl";
  #  ls = "eza -l";
  #  immup = "immich upload -r -a $HOME/images/screenshots";
  #  tu = "sudo tailscale up";
  #  td = "sudo tailscale down";
  #};
}
