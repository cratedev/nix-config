{lib, ...}: {
  programs = {
    chromium = {
      enable = true;
      commandLineArgs = lib.mkDefault ["--enable-features=TouchpadOverscrollHistoryNavigation"];
      extensions = [];
    };

    firefox = {
      enable = true;
      profiles = {
        matt = {}; # Add any Firefox profile-specific configuration here
      };
    };
  };
}
