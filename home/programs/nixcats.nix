{
  inputs,
  system,
  ...
}: let
  stablePkgs = import inputs.nixpkgs {
    inherit system;
    overlays = [
      (final: prev: {
        nixcats = (import inputs.nixpkgs-unstable {inherit system;}).nixcats;
      })
    ];
  };
in {
  home.packages = with stablePkgs; [
    vim
    git
    nixcats # now comes from unstable via overlay
  ];
}
