with (import <nixpkgs> {});
  stdenv.mkDerivation rec {
    pname = "fabric-cli";
    version = "v0.1";

    src = pkgs.lib.cleanSourceWith {
      src = fetchFromGitHub {
        owner = "Fabric-Development";
        repo = "fabric-cli";
        rev = "f8a1576eb42c4dda9ef38fc96d34573a81cac46a";
        sha256 = "sha256-0PVdUlugBLBmLroWepQGXr5de83Nnryam1BleAcVFFw=";
      };
      filter = path: type: builtins.match ".*vendor/.*" path != null || pkgs.lib.cleanSourceFilter path type;
    };

    buildInputs = [go];

    buildPhase = ''
      export HOME=$TMPDIR
      export GOPATH=$TMPDIR/go
      export GOCACHE=$TMPDIR/go-cache
      export GOMODCACHE=$TMPDIR/go-mod
      go build -mod=vendor -o fabric-cli .
    '';

    installPhase = ''
      mkdir -p $out/bin
      cp fabric-cli $out/bin/
    '';
  }
