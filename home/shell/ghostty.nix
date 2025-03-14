{...}: {
  programs.ghostty = {
    enable = true;
    settings = {
      gtk-tabs-location = "hidden";
      #font-family = Noto Sans Mono
      font-size = "10";
      scrollback-limit = "10_000";
      theme = "terafox";
      clipboard-read = "allow";
      clipboard-paste-protection = "false";
      window-decoration = "false";
      window-padding-x = "8";
      window-padding-y = "8";
      window-padding-balance = "true";
      shell-integration = "detect";
      confirm-close-surface = "false";
    };
  };
}
