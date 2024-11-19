{
  description = "Your new nix config";

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
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-cli.url = "github:water-sucks/nixos";
    stylix.url = "github:danth/stylix";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    niri.url = "github:sodiboo/niri-flake";

    nvf.url = "github:notashelf/nvf";
    nvf.inputs.nixpkgs.follows = "nixpkgs";

    agenix.url = "github:yaxitech/ragenix";

  };

  outputs = inputs @ {nixpkgs, ...}: let
    inherit (nixpkgs) lib;

    commonModules = [
      inputs.stylix.nixosModules.stylix
      inputs.nixos-cli.nixosModules.nixos-cli
      inputs.niri.nixosModules.niri
      inputs.home-manager.nixosModules.home-manager
      ./overlays
      ./secrets/default.nix
    ];

    # Function that dynamically takes the system architecture
    createSystemConfig = system: hostFile: extraModules: 
      lib.nixosSystem {
        system = system;  # Use dynamic architecture (e.g., "x86_64-linux" or "aarch64-linux")
        specialArgs = { inherit inputs; };
        modules = lib.concatLists [
          [ hostFile ]
          commonModules # Shared modules
          extraModules  # Extra modules (optional)
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
      crate-laptop = createSystemConfig "x86_64-linux" ./hosts/crate-laptop [ inputs.nixos-hardware.nixosModules.dell-xps-15-9510 ];
      crate-desktop = createSystemConfig "x86_64-linux" ./hosts/crate-desktop [];
    };
  };
}
