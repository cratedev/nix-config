{
  description = "Your new nix config";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-cli.url = "github:water-sucks/nixos";
    stylix.url = "github:danth/stylix";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    niri.url = "github:sodiboo/niri-flake";
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixos-hardware,
    home-manager,
    spicetify-nix,
    stylix,
    niri,
    nvf,
    nixos-cli,
    ...
  }: {
    nixosConfigurations = {
      # Define a generic function to avoid redundancy
      createSystemConfig = systemName: hostFile: nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          hostFile
          ./overlays
          nixos-hardware.nixosModules.dell-xps-15-9510
          stylix.nixosModules.stylix
          nixos-cli.nixosModules.nixos-cli
          niri.nixosModules.niri
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              users.matt = import ./home;
            };
          }
        ];
      };

      crate-laptop = createSystemConfig "crate-laptop" ./hosts/crate-laptop;
      crate-desktop = createSystemConfig "crate-desktop" ./hosts/crate-desktop;
      crate-server = createSystemConfig "crate-server" ./hosts/crate-server;
    };
  };
}
