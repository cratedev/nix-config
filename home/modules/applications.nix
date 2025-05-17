{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs;
    [
      obsidian
    ]
    ++ (
      if pkgs.stdenv.system == "x86_64-linux"
      then [
        inputs.zen-browser.packages.x86_64-linux.default
        (discord.override {withVencord = true;})
      ]
      else []
    );
}
