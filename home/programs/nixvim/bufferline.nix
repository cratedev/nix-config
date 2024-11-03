{
  programs.nixvim = {
    enable = true;
    colorschemes.gruvbox.enable = true;
    plugins = {
      web-devicons.enable = true;
      nix.enable = true;
      gitgutter.enable = true;
      lualine.enable = true;
      bufferline.enable = true;
      multicursors.enable = true;
      oil.enable = true;
      telescope.enable = true;
      fzf-lua.enable = true;
      lazy.enable = true;
      cmp.enable = true;
      nvim-tree.enable = true;
      alpha = {
	enable = true;
	theme = "startify";
      };
    };
    opts = {
      number = true;
      relativenumber = false;
    };
    keymaps = [
      {
        action = "<cmd>NvimTreeToggle<CR>";
        key = "<S-M-f>";
        mode = "n";
        options = {
          desc = "Toggle Tree View.";
        };
      }
      {
        action = "<cmd>Telescope<CR>";
        key = "<S-M-t>";
        mode = "n";
        options = {
          desc = "Telescope";
        };
      }
    ];
  };
}
