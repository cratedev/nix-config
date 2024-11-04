{pkgs, ...}: {
  home.packages = with pkgs; [
    firefox-beta-bin
  ];

  programs = {
    chromium = {
      enable = true;
      commandLineArgs = ["--enable-features=TouchpadOverscrollHistoryNavigation"];
      extensions = [
        # {id = "";}  // extension id, query from chrome web store
      ];
    };

    firefox = {
      enable = true;
      profiles.matt = {};
    };
  };
}
