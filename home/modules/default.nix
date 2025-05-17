{...}: {
  imports = [
    ./utilities.nix
    ./dotfiles.nix
    ./browsers.nix
    ./applications.nix
    ./media.nix
    ./git.nix
    ./nvf.nix
    ./niri.nix
    ./xdg.nix
    ./waybar
    #    ./ags.nix
    #    ./hyprland.nix
  ];
}
