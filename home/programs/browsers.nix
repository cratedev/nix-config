{lib, ...}: {
  #  home.packages = with pkgs; [
  #  ] ++ (if pkgs.stdenv.system == "x86_64-linux" then [ firefox-beta-bin ] else []);

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
        matt = {}; # Add any Firefox profile-specific configuration here
      };
    };
  };
}
