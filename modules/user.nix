# modules/user.nix
{
  pkgs,
  lib,
  ...
}: let
  username = "matt";
  sharedAuthorizedKeys = builtins.readFile ./ssh/authorized_keys;
in {
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = ["networkmanager" "wheel" "docker" "podman" "libvirt"];
    openssh.authorizedKeys.keys = lib.splitString "\n" sharedAuthorizedKeys;
    shell = pkgs.nushell;
  };

  users.groups.libvirt = {};
}
