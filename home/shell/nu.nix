{...}: {
  programs = {
    nushell = {
      enable = true;
      # The config.nu can be anywhere you want if you like to edit your Nushell with Nu
      #      configFile.source = ./.../config.nu;
      # for editing directly to config.nu
      extraConfig = ''
        let carapace_completer = {|spans|
        carapace $spans.0 nushell $spans | from json
        }
        $env.config = {
         show_banner: false,
         completions: {
         case_sensitive: false # case-sensitive completions
         quick: true    # set to false to prevent auto-selecting completions
         partial: true    # set to false to prevent partial filling of the prompt
         algorithm: "fuzzy"    # prefix or fuzzy
         external: {
         # set to false to prevent nushell looking into $env.PATH to find more suggestions
             enable: true
         # set to lower can improve completion performance at the cost of omitting some options
             max_results: 100
             completer: $carapace_completer # check 'carapace_completer'
           }
         }
        }
        $env.PATH = ($env.PATH |
        split row (char esep) |
        prepend /home/matt/.apps |
        append /usr/bin/env
        )
      '';
      shellAliases = {
        vi = "hx";
        vim = "hx";
        nano = "hx";
        garbage = "nix-collect-garbage";
        garbages = "sudo nix-collect-garbage";
        garbaged = "nix-collect-garbage -d";
        garbagesd = "sudo nix-collect-garbage -d";
        cheat = "echo 'Ctrl+T,C - Rename tab'; echo 'Ctrl+B,C - New Tab'; echo 'Ctrl+B, K - Up Pane'; echo 'Ctrl+B, J - Down Pane'";
        #nrsl = "sudo nixos-rebuild switch --flake .#crate-laptop";
        #nrtl = "sudo nixos-rebuild test --flake .#crate-laptop";
        #nrsd = "sudo nixos-rebuild switch --flake .#crate-desktop";
        #nrtd = "sudo nixos-rebuild test --flake .#crate-desktop";
        #nrsm = "sudo nixos-rebuild switch --flake .#crate-mini";
        #nrtm = "sudo nixos-rebuild test --flake .#crate-mini";
        nrs = "sudo nixos-rebuild switch --flake .#($hostname)";
        nrt = "sudo nixos-rebuild test --flake .#($hostname)";
      };
    };
    carapace.enable = true;
    carapace.enableNushellIntegration = true;
  };
}
