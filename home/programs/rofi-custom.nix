{ pkgs, ... }:
#let
#    pkgs = import <nixpkgs> { };
#in

with pkgs;

stdenv.mkDerivation {
    pname = "rofi";
    version = "1.0";

    src = ../../../git/rofi;

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
