{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  buildInputs = [
    pkgs.python3
    pkgs.python3Packages.virtualenv
    pkgs.python3Packages.setproctitle
    pkgs.ninja
    pkgs.meson
    pkgs.pkg-config
    pkgs.cairo
    pkgs.gobject-introspection
    pkgs.gtk3            # Provides GTK+ 3 libraries and typelibs
#    pkgs.gobjectIntrospection  # Ensures GI typelibs are available
    pkgs.gtk-layer-shell
#    pkgs.libgirepository
    pkgs.python313Packages.setproctitle
  ];

  shellHook = ''
    if [ ! -d venv ]; then
      virtualenv venv
    fi
    source venv/bin/activate
    pip install git+https://github.com/Fabric-Development/fabric.git
  '';
}
