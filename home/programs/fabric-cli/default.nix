{pkgs, ...}:
pkgs.stdenv.mkDerivation {
  pname = "fabric-cli";
  version = "unstable-2024-02-04";

  src = pkgs.fetchFromGitHub {
    owner = "Fabric-Development";
    repo = "fabric-cli";
    rev = "main";
    sha256 = "00000000000000000000000000000000000000000000"; # Replace with actual hash
  };

  nativeBuildInputs = [pkgs.go];

  buildPhase = ''
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
  };
}
