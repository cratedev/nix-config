{
  description = "Your new nix config";

  nixConfig = {
    # substituers will be appended to the default substituters when fetching packages
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-cli.url = "github:water-sucks/nixos";
    stylix.url = "github:danth/stylix";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    niri.url = "github:sodiboo/niri-flake";
    wezterm.url = "github:wez/wezterm/main?dir=nix";
#    nixvim = {
#	url = "github:nix-community/nixvim";
#	inputs.nixpkgs.follows = "nixpkgs";
#    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixos-hardware,
    home-manager,
    spicetify-nix,
    stylix,
    niri,
    wezterm,
#    nixvim,
    nixos-cli,
    ...
  }: {
    nixosConfigurations = {
      crate-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	    specialArgs = { inherit inputs; };
        modules = [
          ./hosts/crate-laptop
	      ./overlays
          nixos-hardware.nixosModules.dell-xps-15-9510
          stylix.nixosModules.stylix
          nixos-cli.nixosModules.nixos-cli
          niri.nixosModules.niri
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.matt = import ./home;
	  }
        ];
      };

      crate-desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/crate-desktop
	      ./overlays
          stylix.nixosModules.stylix
          nixos-cli.nixosModules.nixos-cli
          niri.nixosModules.niri
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.matt = import ./home;
          }
        ];
      };

      crate-server = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/crate-server
	      ./overlays
          stylix.nixosModules.stylix
          nixos-cli.nixosModules.nixos-cli
          niri.nixosModules.niri
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.matt = import ./home;
          }
        ];
      };
    };
  };
}
