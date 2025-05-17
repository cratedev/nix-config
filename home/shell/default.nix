{pkgs, ...}: {
  imports = [
    ./zellij
    ./nu.nix
    ./ghostty.nix
  ];

  home.packages = with pkgs; [
    zellij
  ];
  programs = {
    tmux.enable = true;
  };
}
