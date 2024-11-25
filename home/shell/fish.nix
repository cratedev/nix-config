{...}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
    '';
    shellAliases = {
      ls = "eza -l";
      garbage = "nix-collect-garbage";
      garbages = "sudo nix-collect-garbage";
      garbaged = "nix-collect-garbage -d";
      garbagesd = "sudo nix-collect-garbage -d";
      cheat = "echo 'Ctrl+T,C - Rename tab'; echo 'Ctrl+B,C - New Tab'; echo 'Ctrl+B, K - Up Pane'; echo 'Ctrl+B, J - Down Pane'";
      nrsl = "sudo nixos-rebuild switch --flake .#crate-laptop";
      nrtl = "sudo nixos-rebuild test --flake .#crate-laptop";
      nrsd = "sudo nixos-rebuild switch --flake .#crate-desktop";
      nrtd = "sudo nixos-rebuild test --flake .#crate-desktop";
      nrsm = "sudo nixos-rebuild switch --flake .#crate-mini";
      nrtm = "sudo nixos-rebuild test --flake .#crate-mini";
    };
  };
}
