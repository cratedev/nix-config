{
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.spicetify-nix.homeManagerModules.default];

  home.packages = with pkgs; [
    # Audio control
    pavucontrol
    playerctl
    pulsemixer
    pamixer
    # Image viewer
    imv
    # Video players
    mpv
    vlc
    # CLI tools
    ytfzf
    youtube-music
  ];

  programs = {
    spotify-player.enable = true;
    ncspot.enable = true;
    spicetify = {
      enable = true;
      enabledExtensions = with inputs.spicetify-nix.legacyPackages.${pkgs.system}.extensions; [
        adblock
        hidePodcasts
        shuffle
      ];
      theme = lib.mkForce inputs.spicetify-nix.legacyPackages.${pkgs.system}.themes.catppuccin;
      colorScheme = lib.mkForce "mocha";
    };
  };

  services.playerctld.enable = true;
}
