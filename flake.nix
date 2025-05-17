{
  description = "crate NixOS configuration";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    # Secrets (non-flake)
    mysecrets = {
      url = "git+ssh://git@github.com/cratedev/nix-secrets";
      flake = false;
    };

    # Core system
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Modules and tools
    stylix.url = "github:danth/stylix";
    niri.url = "github:sodiboo/niri-flake/d21e04836830680650bf44fa3d8ab80d7ea762bd";
    agenix.url = "github:yaxitech/ragenix";
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ghostty.url = "github:ghostty-org/ghostty";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    ags.url = "github:Aylur/ags";

    # Hardware support
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Spicetify config
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
  };

  outputs = inputs @ {nixpkgs, ...}: let
    inherit (nixpkgs) lib;

    # Shared modules used across all hosts
    commonModules = [
      inputs.stylix.nixosModules.stylix
      inputs.niri.nixosModules.niri
      inputs.home-manager.nixosModules.home-manager
      ./secrets/default.nix
    ];

    # Home-manager configuration for user `matt`
    homeManagerModule = {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {inherit inputs;};
        users.matt = {
          imports = [./home];
        };
      };
    };

    # Helper function to create system configurations
    createSystemConfig = system: hostFile: extraModules:
      lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs;};
        modules =
          [
            hostFile
          ]
          ++ commonModules ++ extraModules ++ [homeManagerModule];
      };
  in {
    nixosConfigurations = {
      crate-laptop = createSystemConfig "x86_64-linux" ./hosts/crate-laptop [
        inputs.nixos-hardware.nixosModules.dell-xps-15-9510
      ];
      crate-desktop = createSystemConfig "x86_64-linux" ./hosts/crate-desktop [];
      crate-mini = createSystemConfig "aarch64-linux" ./hosts/crate-mini [];
    };
  };
}
