{ ... }: {
  imports = let
    archSpecificImports =
      if builtins.currentSystem == "x86_64-linux" then
        [ 
          ./x86-specific.nix
          ./browsers.nix
        ]
      else if builtins.currentSystem == "aarch64-linux" then
        [ 
          ./arm-specific.nix
        ]
      else
        []; # Default to no specific imports for other architectures
  in
    archSpecificImports ++ [
      ./common.nix
      ./git.nix
      ./media.nix
      ./xdg.nix
      ./nvf.nix
    ];
}
