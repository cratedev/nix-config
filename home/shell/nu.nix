{...}: {
  programs = {
    nushell = {
      enable = true;
      # The config.nu can be anywhere you want if you like to edit your Nushell with Nu
      #      configFile.source = ./.../config.nu;
      # for editing directly to config.nu
      extraConfig = ''
        source ~/nix-config/scripts/set_hostname.nu
             				$env.config.color_config = {
               separator: "#878d96"
               leading_trailing_space_bg: "#c8c8c8"
               header: "#98c379"
               date: "#e799ff"
               filesize: "#6bb8ff"
               row_index: "#8af5ff"
               bool: "#fa7883"
               int: "#98c379"
               duration: "#fa7883"
               range: "#fa7883"
               float: "#fa7883"
               string: "#c8c8c8"
               nothing: "#fa7883"
               binary: "#fsa7883"
               cellpath: "#fa7883"
               hints: dark_gray

               shape_garbage: { fg: "#ffffff" bg: "#fa7883" }
               shape_bool: "#6bb8ff"
               shape_int: { fg: "#e799ff" attr: b }
               shape_float: { fg: "#e799ff" attr: b }
               shape_range: { fg: "#ff9470" attr: b }
               shape_internalcall: { fg: "#8af5ff" attr: b }
               shape_external: "#8af5ff"
               shape_externalarg: { fg: "#98c379" attr: b }
               shape_literal: "#6bb8ff"
               shape_operator: "#ff9470"
               shape_signature: { fg: "#98c379" attr: b }
               shape_string: "#98c379"
               shape_filepath: "#6bb8ff"
               shape_globpattern: { fg: "#6bb8ff" attr: b }
               shape_variable: "#e799ff"
               shape_flag: { fg: "#6bb8ff" attr: b }
               shape_custom: { attr: b }
             }

             source /home/matt/.local/cache/carapace/init.nu

             alias "garbage" = nix-collect-garbage
             alias "garbaged" = nix-collect-garbage -d
             alias "garbages" = sudo nix-collect-garbage
             alias "garbagesd" = sudo nix-collect-garbage -d
             alias "la" = eza -a
             alias "ll" = eza -l
             alias "lla" = eza -la
             alias "ls" = eza
             alias "lt" = eza --tree
             alias "nrs" = sudo nixos-rebuild switch --flake .#($hostname)
             alias "nrt" = sudo nixos-rebuild test --flake .#($hostname)
      '';
      shellAliases = {
        garbage = "nix-collect-garbage";
        garbages = "sudo nix-collect-garbage";
        garbaged = "nix-collect-garbage -d";
        garbagesd = "sudo nix-collect-garbage -d";
        nrs = "sudo nixos-rebuild switch --flake .#($hostname)";
        nrt = "sudo nixos-rebuild test --flake .#($hostname)";
      };
    };
    carapace.enable = true;
    carapace.enableNushellIntegration = true;
    starship = {
      enable = false;
      enableNushellIntegration = true;
      settings = {
        format = "$directory$all$cmd_duration$jobs$status$shell$line_break$env_var$username$sudo$character";
        right_format = "$battery$time";
        add_newline = true;
        character = {
          format = "$symbol ";
          success_symbol = "[●](bright-green)";
          error_symbol = "[●](red)";
          vicmd_symbol = "[◆](blue)";
        };
        sudo = {
          format = "[$symbol]($style)";
          style = "bright-purple";
          symbol = ":";
          disabled = true;
        };
        username = {
          style_user = "yellow bold";
          style_root = "purple bold";
          format = "[$user]($style) ▻ ";
          disabled = false;
          show_always = false;
        };
        directory = {
          home_symbol = "⌂";
          truncation_length = 2;
          truncation_symbol = "□ ";
          read_only = " △";
          use_os_path_sep = true;
          style = "bright-blue";
        };
        git_branch = {
          format = "[$symbol $branch(:$remote_branch)]($style) ";
          symbol = "[△](green)";
          style = "green";
        };
        git_status = {
          format = "($ahead_behind$staged$renamed$modified$untracked$deleted$conflicted$stashed)";
          conflicted = "[◪ ]( bright-magenta)";
          ahead = "[▲ [$count](bold white) ](green)";
          behind = "[▼ [$count](bold white) ](red)";
          diverged = "[◇ [$ahead_count](bold green)/[$behind_count](bold red) ](bright-magenta)";
          untracked = "[○ ](bright-yellow)";
          stashed = "[$count ](bold white)";
          renamed = "[● ](bright-blue)";
          modified = "[● ](yellow)";
          staged = "[● ](bright-cyan)";
          deleted = "[✕ ](red)";
        };
        deno = {
          format = "deno [∫ $version](blue ) ";
          version_format = "$major.$minor";
        };
        nodejs = {
          format = "node [◫ ($version)]( bright-green) ";
          detect_files = ["package.json"];
          version_format = "$major.$minor";
        };
        rust = {
          format = "rs [$symbol$version]($style) ";
          symbol = "⊃ ";
          version_format = "$major.$minor";
          style = "red";
        };
        package = {
          format = "pkg [$symbol$version]($style) ";
          version_format = "$major.$minor";
          symbol = "◫ ";
          style = "bright-yellow ";
        };
        nix_shell = {
          symbol = "⊛ ";
          format = "nix [$symbol$state $name]($style) ";
        };
      };
    };
  };
}
