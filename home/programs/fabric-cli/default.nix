{pkgs ? import <nixpkgs> {}}:
pkgs.stdenv.mkDerivation rec {
  pname = "fabric-cli";
  version = "v0.1";

  # Add this line to mark build as impure (allowing network access)
  __impure = true;

  src = pkgs.lib.cleanSourceWith {
    src = pkgs.fetchFromGitHub {
      owner = "Fabric-Development";
      repo = "fabric-cli";
      rev = "f8a1576eb42c4dda9ef38fc96d34573a81cac46a";
      sha256 = "sha256-0PVdUlugBLBmLroWepQGXr5de83Nnryam1BleAcVFFw=";
    };
    filter = path: type: builtins.match ".*vendor/.*" path == null && pkgs.lib.cleanSourceFilter path type;
  };

  buildInputs = [pkgs.go pkgs.git];

  # Add these lines to allow network access during build
  outputHashMode = "recursive";
  outputHashAlgo = "sha256";

  buildPhase = ''
    export HOME=$TMPDIR
    export GOPATH=$TMPDIR/go
    export GOCACHE=$TMPDIR/go-cache
    export GOMODCACHE=$TMPDIR/go-mod
    export GOPROXY=https://proxy.golang.org
    export CGO_ENABLED=0
    go build -mod=readonly -o fabric-cli .
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp fabric-cli $out/bin/
  '';
}
