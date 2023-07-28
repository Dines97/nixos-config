{
  stdenv,
  lib,
  fetchzip,
  autoreconfHook,
  pkg-config,
  help2man,
  glib,
}: let
  pname = "preload";
  version = "0.6.4";
in
  stdenv.mkDerivation {
    inherit pname version;

    src = fetchzip {
      url = "http://downloads.sourceforge.net/sourceforge/preload/${pname}-${version}.tar.gz";
      hash = "sha256-vAIaSwvbUFyTl6DflFhuSaMuX9jPVBah+Nl6c/fUbAM=";
    };

    nativeBuildInputs = [autoreconfHook pkg-config help2man];
    buildInputs = [glib];

    outputs = ["out" "man"];

    configureFlags = [
      "--localstatedir=/var"
      "--mandir=$(man)/share/man"
      "--sbindir=$(out)/bin"
      "--sysconfdir=/etc"
    ];

    installFlags = [
      "localstatedir=$(out)/var"
      "sysconfdir=$(out)/etc"
    ];

    meta = with lib; {
      license = licenses.gpl2;
      homepage = "http://sourceforge.net/projects/preload";
      description = "Makes applications run faster by prefetching binaries and shared objects";
    };
  }
