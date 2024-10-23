{ libs, pkgs, ... }:
let
    pkgs = import <nixpkgs> { };
in

with pkgs;

stdenv.mkDerivation {
    pname = "rofi-custom";
    version = "1.0";

    src = ../../../git/rofi;

    buildPhase = ''
        meson configure
	ninja
	ninja install
    '';

    nativeBuildInputs = [
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
      git
      doxygen
      cppcheck
    ];
}
