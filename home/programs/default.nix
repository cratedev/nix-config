{ inputs, pkgs, lib, ... }:
{
  imports = [
    ./browsers.nix
    ./common.nix
    ./git.nix
    ./media.nix
    ./xdg.nix
    ./dots
    ./nixvim
    inputs.nixvim.homeManagerModules.nixvim
  ];
}
