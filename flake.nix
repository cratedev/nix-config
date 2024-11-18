{
  description = "Your new nix config";

  nixConfig = {
    extra-substituters = [ "https://nix-community.cachix.org" ];
    extra-trusted-public-keys = [ 
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" 
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-cli.url = "github:water-sucks/nixos";
    stylix.url = "github:danth/stylix";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    niri.url = "github:sodiboo/niri-flake";

    nvf.url = "github:notashelf/nvf";
    nvf.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ { self, nixpkgs, ... }: let
    lib = nixpkgs.lib;
    commonModules = [
      inputs.stylix.nixosModules.stylix
      inputs.nixos-cli.nixosModules.nixos-cli
      inputs.niri.nixosModules.niri
      inputs.home-manager.nixosModules.home-manager
      ./overlays
    ];

    createSystemConfig = hostFile: extraModules: lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = lib.concatLists [
        [ hostFile ]          # Host-specific configuration
        commonModules         # Shared modules
        extraModules          # Extra modules (optional)
        [
          {
            home-manager = { 
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              users.matt = import ./home;
            };
          }
        ]
      ];
    };
  in {
    nixosConfigurations = {
      crate-laptop = createSystemConfig ./hosts/crate-laptop [
        inputs.nixos-hardware.nixosModules.dell-xps-15-9510
      ];
      crate-desktop = createSystemConfig ./hosts/crate-desktop [];
      crate-server = createSystemConfig ./hosts/crate-server [];
    };
  };
}
