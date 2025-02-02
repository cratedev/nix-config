{inputs, ...}: {
  imports = [inputs.nvf.homeManagerModules.default];

  programs.nvf = {
    enable = true;
    settings.vim = {
      maps = {
        normal."<leader><Left>" = {
          silent = true;
          action = "<cmd>bprev<CR>";
        };
        normal."<leader><Right>" = {
          silent = true;
          action = "<cmd>bnext<CR>";
        };
      };
      viAlias = true;
      vimAlias = true;

      # Debug Mode (optional)
      debugMode = {enable = false;};

      # Language Server Protocol (LSP) settings
      lsp = {
        formatOnSave = true;
        lightbulb.enable = true;
        trouble.enable = true;
        lspSignature.enable = true;
        lsplines.enable = true;
      };

      # Debugger
      debugger = {
        nvim-dap = {
          enable = true;
          ui.enable = true;
        };
      };

      # Languages and Formatters
      languages = {
        enableLSP = true;
        enableFormat = true;
        enableTreesitter = true;
        enableExtraDiagnostics = true;
        nix.enable = true; # Enable Nix LSP (Note: Nim LSP disabled on Darwin)
      };

      # Visuals and UI
      visuals = {
        nvim-web-devicons.enable = true;
        cinnamon-nvim.enable = true;
        fidget-nvim.enable = true;
        highlight-undo.enable = true;
        indent-blankline.enable = true;
        nvim-cursorline = {
          enable = true;
          setupOpts.line_timeout = 0;
        };
      };

      # Statusline & Theme
      statusline = {
        lualine = {
          enable = true;
          theme = "catppuccin";
        };
      };
      theme = {
        enable = true;
        name = "catppuccin";
        style = "mocha";
        transparent = false;
      };

      # General features
      autopairs.nvim-autopairs.enable = true;
      autocomplete.nvim-cmp.enable = true;
      filetree = {nvimTree = {enable = true;};};
      tabline = {nvimBufferline.enable = true;};
      treesitter.context.enable = true;

      # Miscellaneous Features
      binds = {
        whichKey.enable = true;
        cheatsheet.enable = true;
      };
      telescope.enable = true;

      # Git & Version Control
      git = {
        enable = true;
        gitsigns.enable = true;
        gitsigns.codeActions.enable = false;
      };

      # Minimap & Dashboard
      minimap = {minimap-vim.enable = false;};
      dashboard = {dashboard-nvim.enable = false;};

      # Notifications & Utility
      notify = {nvim-notify.enable = true;};
      utility = {
        diffview-nvim.enable = true;
        motion = {
          hop.enable = true;
          leap.enable = true;
        };
      };

      # Notes & Comments
      notes = {todo-comments.enable = true;};
      comments = {comment-nvim.enable = true;};

      # Terminal & Session Management
      terminal = {
        toggleterm = {
          enable = true;
          lazygit.enable = true;
        };
      };

      # UI Enhancements
      ui = {
        borders.enable = true;
        noice.enable = true;
        colorizer.enable = true;
        illuminate.enable = true;
        smartcolumn = {
          enable = true;
          setupOpts.custom_colorcolumn = {
            nix = "110";
            ruby = "120";
            java = "130";
            go = ["90" "130"];
          };
        };
        fastaction.enable = true;
      };

      # Disable unnecessary features
      assistant = {
        chatgpt.enable = false;
        copilot.enable = false;
      };
      session = {nvim-session-manager.enable = false;};
      gestures = {gesture-nvim.enable = false;};
      presence = {neocord.enable = false;};
    };
  };
}
