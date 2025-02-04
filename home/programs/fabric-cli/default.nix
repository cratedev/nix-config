{pkgs ? import <nixpkgs> {}}:
pkgs.stdenv.mkDerivation {
  pname = "fabric-cli";
  version = "unstable-2024-02-04"; # Update as needed
  src = pkgs.fetchFromGitHub {
    owner = "Fabric-Development";
    repo = "fabric-cli";
    rev = "main"; # Pin a specific commit if needed
    sha256 = "00000000000000000000000000000000000000000000"; # Replace with actual hash
  };

  nativeBuildInputs = [pkgs.go];

  buildPhase = ''
    mkdir -p $GOPATH/src/github.com/Fabric-Development
    ln -s $src $GOPATH/src/github.com/Fabric-Development/fabric-cli
    cd $GOPATH/src/github.com/Fabric-Development/fabric-cli
    go build -o fabric-cli
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp fabric-cli $out/bin/
  '';

  meta = {
    description = "Fabric CLI for interacting with Fabric instances over D-Bus";
    homepage = "https://github.com/Fabric-Development/fabric-cli";
    license = pkgs.lib.licenses.mit;
    maintainers = with pkgs.lib.maintainers; [];
  };
}
