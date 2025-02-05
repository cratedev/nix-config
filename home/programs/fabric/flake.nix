{
  description = "Fabric";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs = {
    self,
    nixpkgs,
  }: {
    # Define the fabric package as an installable Python package
    packages.x86_64-linux.fabric = nixpkgs.legacyPackages.x86_64-linux.python3Packages.buildPythonPackage {
      pname = "fabric";
      version = "latest";

      # Use the GitHub repository as the source
      src = nixpkgs.legacyPackages.x86_64-linux.fetchFromGitHub {
        owner = "Fabric-Development";
        repo = "fabric";
        rev = "master"; # You can pin this to a specific commit for reproducibility
        sha256 = "sha256-5yMT4AZpUKHV+Th21zsAWmTQUwNk079zP7IOD2ASWlI="; # Replace with actual hash after first build
      };

      # Dependencies required to build and run fabric
      propagatedBuildInputs = with nixpkgs.legacyPackages.x86_64-linux.python3Packages; [
        setproctitle
        virtualenv
      ];

      nativeBuildInputs = with nixpkgs.legacyPackages.x86_64-linux; [
        ninja
        meson
        pkg-config
        cairo
        gobject-introspection
        gtk3
        gtk-layer-shell
      ];

      meta = with nixpkgs.lib; {
        description = "Fabric - A Python-based tool";
        license = licenses.mit;
        maintainers = [maintainers.yourName]; # Replace with your name or GitHub handle
      };
    };

    # Set the default package to fabric, so it can be installed as `.#default`
    defaultPackage.x86_64-linux = self.packages.x86_64-linux.fabric;

    # Optional: Define a development shell for working on fabric locally
    devShells.x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.mkShell {
      buildInputs = with nixpkgs.legacyPackages.x86_64-linux; [
        python3
        python3Packages.virtualenv
        python3Packages.setproctitle
        gobject-introspection
        gtk3
        gtk-layer-shell
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
