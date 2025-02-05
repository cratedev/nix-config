{pkgs ? import <nixpkgs> {}, ...}:
pkgs.buildGoModule rec {
  pname = "fabric-cli";
  version = "v0.1";

  src = pkgs.fetchFromGitHub {
    owner = "Fabric-Development";
    repo = "fabric-cli";
    rev = "f8a1576eb42c4dda9ef38fc96d34573a81cac46a";
    sha256 = "sha256-0PVdUlugBLBmLroWepQGXr5de83Nnryam1BleAcVFFw=";
  };

  vendorHash = "sha256-3ToIL4MmpMBbN8wTaV3UxMbOAcZY8odqJyWpQ7jkXOc="; # Replace this after first build

  nativeBuildInputs = [pkgs.go pkgs.git pkgs.curl];

  dontPatchELF = true;

  buildPhase = ''
    export GOPATH=$TMPDIR/go
    export GOCACHE=$TMPDIR/go-cache
    export GOMODCACHE=$TMPDIR/go-mod
    export GOPROXY=direct
    export CGO_ENABLED=0
    go build -mod=vendor -o fabric-cli .
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp fabric-cli $out/bin/
  '';

  meta = with pkgs.lib; {
    description = "Command-line interface for Fabric development";
    license = licenses.mit;
    maintainers = with maintainers; [yourName];
  };
}

