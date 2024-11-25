{ lib, ... }: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
    '';

    shellAliases = let
      nixCommands = {
        crate-laptop = "crate-laptop";
        crate-desktop = "crate-desktop";
        crate-mini = "crate-mini";
      };
      nixAlias = cmd: flake: "sudo nixos-rebuild ${cmd} --flake .#${flake}";
      generatedAliases = lib.foldl' (merged: attrSet: merged // attrSet) {} 
        (lib.mapAttrsToList (name: flake: {
          "nr${name}s" = nixAlias "switch" flake;
          "nr${name}t" = nixAlias "test" flake;
        }) nixCommands);
    in {
      ls = "eza -l";
      garbage = "nix-collect-garbage";
      garbages = "sudo nix-collect-garbage";
      garbaged = "nix-collect-garbage -d";
      garbagesd = "sudo nix-collect-garbage -d";
      cheat = "echo 'Ctrl+T,C - Rename tab'; echo 'Ctrl+B,C - New Tab'; echo 'Ctrl+B, K - Up Pane'; echo 'Ctrl+B, J - Down Pane'";
    } // generatedAliases;
  };
}
