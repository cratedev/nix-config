let
    pkgs = import <nixpkgs> { };
in

with pkgs;

stdenv.mkDerivation {
    pname = "rofi";
    version = "1.7.4";

    src = ../../git/rofi;

    buildPhase = ''
        meson setup build
        ninja -C build
    '';

    installPhase = ''
        ninja -C build install
    '';
}
