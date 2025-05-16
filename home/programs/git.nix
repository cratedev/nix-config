{pkgs, ...}: {
  home.packages = with pkgs; [gh];

  programs.git = {
    enable = true;
    userName = "cratedev";
    userEmail = "matt@crate.dev";
    package = pkgs.gitFull;

    extraConfig = {
      init.defaultBranch = "master";
      # Uncomment if using a credential helper
      # credential.helper = "libresecret";
    };

    aliases.st = "status";
  };
}
