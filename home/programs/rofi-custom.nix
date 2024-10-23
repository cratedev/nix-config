{ pkgs, fetchFromGitHub, ... }:
#let
#    pkgs = import <nixpkgs> { };
#in

with pkgs;

stdenv.mkDerivation {
    pname = "rofi";
    version = "1.0";

    src = fetchFromGitHub {
	owner = "lbonn";
	repo = "rofi";
	rev = "142e78071cbd7ddc2228cc707a583e081ec3bdf2";
	sha256 = "sha256-erdWUek1dKps8GFfBcg2vLK7W7hat+zMpr+ef4fPqEo=";
    };

    buildPhase = ''
        meson configure
	ninja
	ninja install
    '';

    nativeBuildInputs = with pkgs; [
      meson
      cmake
      autoconf
      automake
      ninja
      flex
      bison
      check
      glib
      cairo
      pango
      libxkbcommon
      gdk-pixbuf
      pkg-config
      xcbutilxrm
      xcb-util-cursor
      xcb-imdkit
      xorg.xcbutilwm
      xorg.xcbutil
      xorg.xcbutilkeysyms
      libstartup_notification
      kdePackages.wayland-protocols
      wayland
      wayland-scanner
#      git
      doxygen
      cppcheck
    ];
}
