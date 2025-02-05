{
  description = "crate";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  inputs = {
    mysecrets = {
      url = "git+ssh://git@github.com/cratedev/nix-secrets";
      flake = false;
    };
    agenix.url = "github:yaxitech/ragenix";

    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    niri.url = "github:sodiboo/niri-flake";
    nvf.url = "github:notashelf/nvf";
    nvf.inputs.nixpkgs.follows = "nixpkgs";
    ghostty.url = "github:ghostty-org/ghostty";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    #hyprland.url = "github:hyprwm/Hyprland";
    #hyprland-plugins = {
    #url = "github:hyprwm/hyprland-plugins";
    #inputs.hyprland.follows = "hyprland";
    #};
    #fabric.url = "github:Fabric-Development/fabric";
    #fabric.flake = true; # Use Fabric flake
    #fabric.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {nixpkgs, ...}: let
    inherit (nixpkgs) lib;
    commonModules = [
      inputs.stylix.nixosModules.stylix
      inputs.niri.nixosModules.niri
      inputs.home-manager.nixosModules.home-manager
      ./secrets/default.nix
    ];

    # Function that dynamically takes the system architecture
    createSystemConfig = system: hostFile: extraModules:
      lib.nixosSystem {
        inherit system; # Use dynamic architecture (e.g., "x86_64-linux" or "aarch64-linux")
        specialArgs = {inherit inputs;};
        modules = lib.concatLists [
          [hostFile]
          commonModules # Shared modules
          extraModules # Extra modules (optional)
          [
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {inherit inputs;};
                users.matt = {
                  imports = [
                    ./home
                    #./home/programs/hyprland.nix
                  ];
                };
              };
            }
          ]
        ];
      };
  in {
    nixosConfigurations = {
      crate-laptop = createSystemConfig "x86_64-linux" ./hosts/crate-laptop [inputs.nixos-hardware.nixosModules.dell-xps-15-9510];
      crate-desktop = createSystemConfig "x86_64-linux" ./hosts/crate-desktop [];
      crate-mini = createSystemConfig "aarch64-linux" ./hosts/crate-mini [];
    };
  };
}
