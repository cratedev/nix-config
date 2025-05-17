{
  description = "crate";

  nixConfig = {
    extra-substituters = ["https://nix-community.cachix.org"];
    extra-trusted-public-keys = ["nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="];
  };

  inputs = {
    mysecrets = {
      url = "git+ssh://git@github.com/cratedev/nix-secrets";
      flake = false;
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri.url = "github:sodiboo/niri-flake/d21e04836830680650bf44fa3d8ab80d7ea762bd";
    agenix.url = "github:yaxitech/ragenix";
    ghostty.url = "github:ghostty-org/ghostty";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {nixpkgs, ...}: let
    inherit (nixpkgs) lib;

    commonModules = [
      inputs.stylix.nixosModules.stylix
      inputs.niri.nixosModules.niri
      inputs.home-manager.nixosModules.home-manager
      ./secrets/default.nix
    ];

    homeManagerModule = {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {inherit inputs;};
        users.matt = {imports = [./home];};
      };
    };

    createSystemConfig = system: hostFile: extraModules:
      lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs;};
        modules =
          [hostFile]
          ++ commonModules ++ extraModules ++ [homeManagerModule];
      };
  in {
    nixosConfigurations = {
      crate-desktop = createSystemConfig "x86_64-linux" ./hosts/crate-desktop [];
      crate-mini = createSystemConfig "aarch64-linux" ./hosts/crate-mini [];
      crate-laptop = createSystemConfig "x86_64-linux" ./hosts/crate-laptop [
        inputs.nixos-hardware.nixosModules.dell-xps-15-9510
      ];
    };
  };
}
