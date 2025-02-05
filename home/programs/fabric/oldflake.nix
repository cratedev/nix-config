{
  description = "Fabric";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux.fabric = nixpkgs.legacyPackages.x86_64-linux.mkShell {
      buildInputs = with nixpkgs.legacyPackages.x86_64-linux; [
        python3
        python3Packages.virtualenv
        python3Packages.setproctitle
        ninja
        meson
        pkg-config
        cairo
        gobject-introspection
        gtk3
        gtk-layer-shell
        python313Packages.setproctitle
      ];

      shellHook = ''
        if [ ! -d venv ]; then
          virtualenv venv
        fi
        source venv/bin/activate
        pip install git+https://github.com/Fabric-Development/fabric.git
      '';
    };

    defaultPackage.x86_64-linux = self.packages.x86_64-linux.fabric;
  };
}
