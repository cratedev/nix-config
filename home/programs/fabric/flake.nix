{
  description = "Fabric CLI";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux.fabric-cli = nixpkgs.legacyPackages.x86_64-linux.mkShell {
      buildInputs = [
        nixpkgs.python3
        nixpkgs.python3Packages.virtualenv
        nixpkgs.python3Packages.setproctitle
        nixpkgs.ninja
        nixpkgs.meson
        nixpkgs.pkg-config
        nixpkgs.cairo
        nixpkgs.gobject-introspection
        nixpkgs.gtk3
        nixpkgs.gtk-layer-shell
        nixpkgs.python313Packages.setproctitle
      ];

      shellHook = ''
        if [ ! -d venv ]; then
          virtualenv venv
        fi
        source venv/bin/activate
        pip install git+https://github.com/Fabric-Development/fabric.git
      '';
    };
  };
}
