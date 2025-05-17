{config, ...}: let
  browser = ["firefox.desktop"];
  mpv = ["mpv.desktop"];
  imv = ["imv.desktop"];
  zathura = ["org.pwmt.zathura.desktop"];
  discord = ["discordcanary.desktop"];
  spotify = ["spotify.desktop"];
  telegram = ["telegramdesktop.desktop"];

  # XDG MIME types
  associations = {
    # Web-related
    "application/x-extension-htm" = browser;
    "application/x-extension-html" = browser;
    "application/x-extension-shtml" = browser;
    "application/x-extension-xht" = browser;
    "application/x-extension-xhtml" = browser;
    "application/xhtml+xml" = browser;
    "text/html" = browser;
    "x-scheme-handler/about" = browser;
    "x-scheme-handler/ftp" = browser;
    "x-scheme-handler/http" = browser;
    "x-scheme-handler/https" = browser;
    "x-scheme-handler/unknown" = browser;
    "x-scheme-handler/chrome" = ["chromium-browser.desktop"];

    # Media-related
    "audio/*" = mpv;
    "video/*" = mpv;
    "image/*" = imv;

    # Other formats
    "application/json" = browser;
    "application/pdf" = zathura;

    # Apps
    "x-scheme-handler/discord" = discord;
    "x-scheme-handler/spotify" = spotify;
    "x-scheme-handler/tg" = telegram;
  };
in {
  xdg = {
    enable = true;
    cacheHome = config.home.homeDirectory + "/.local/cache";

    mimeApps = {
      enable = true;
      defaultApplications = associations;
    };

    userDirs = {
      enable = false;
      createDirectories = false;
      extraConfig = {
        XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/Screenshots";
      };
    };
    desktopEntries."1password" = {
      name = "1Password";
      exec = "1password --ozone-platform=wayland";
      terminal = false;
      type = "Application";
      categories = ["Utility"];
    };
  };
}
