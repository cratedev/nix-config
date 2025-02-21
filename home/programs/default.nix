{...}: {
  imports = [
    ./common.nix
    ./browsers.nix
    ./niri.nix
    ./git.nix
    ./media.nix
    ./xdg.nix
    ./nvf.nix
    ./waybar/default.nix
    ./ags
  ];
}
