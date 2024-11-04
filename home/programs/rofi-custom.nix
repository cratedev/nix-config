{pkgs, ...}:
with pkgs;
  stdenv.mkDerivation {
    pname = "rofi";
    version = "1.0";

    src = fetchgit {
      url = "https://github.com/lbonn/rofi";
      rev = "142e78071cbd7ddc2228cc707a583e081ec3bdf2";
      sha256 = "sha256-hb6AbqAN2I+icrPOTkJZtMghDcVPUGm7y2viG3fuALg=";
      fetchSubmodules = true;
    };

    buildPhase = ''
      meson configure
      ninja
    '';

    installPhase = ''
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
      git
      doxygen
      cppcheck
    ];
  }
