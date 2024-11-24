{ pkgs, lib, ... }: {
  home.packages = with pkgs; [
#    firefox-beta-bin
  ];

  programs = {
    # Chromium Browser
    chromium = {
      enable = true;
      commandLineArgs = lib.mkDefault ["--enable-features=TouchpadOverscrollHistoryNavigation"];
      extensions = [];
    };

    # Firefox Browser
    firefox = {
      enable = true;
      profiles = {
        matt = {};  # Add any Firefox profile-specific configuration here
      };
    };
  };
}
