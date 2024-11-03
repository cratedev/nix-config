{
  programs.nixvim = {
    enable = true;
    colorschemes.gruvbox.enable = true;
    plugins = {
      bufferline.enable = true;
      web-devicons.enable = true;
      nix.enable = true;
      gitgutter.enable = true;
      lualine.enable = true;
      alpha = {
	enable = true;
	theme = "startify";
      };
    };
    opts = {
      number = true;
      relativenumber = false;
    };
  };
}
