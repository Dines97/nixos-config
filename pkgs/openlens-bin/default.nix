{
  stdenv,
  fetchurl,
  appimageTools,
  autoPatchelfHook,
  expat,
  glib,
  lib,
  libxcb,
  libXrandr,
  libXfixes,
  libXdamage,
  libXcomposite,
  cairo,
  pango,
  gtk3,
  nss,
  ffmpeg,
  nwjs,
}: let
  pname = "openlens";
  version = "6.3.0";

  owner = "beliys";
  repo = "OpenLens";

  src = fetchurl {
    url = " https://github.com/${owner}/${repo}/releases/download/v${version}/OpenLens-${version}.x86_64.AppImage";
    sha256 = "sha256-72qzswHlSk33zPUN1Wa7vcEYc3CERVAAjGsIlhU6AlM=";
  };
in
  stdenv.mkDerivation (attrs: {
    pname = "openlens-bin";
    version = "6.3.0";
    src = appimageTools.extractType2 {inherit src pname version;};

    nativeBuildInputs = [
      autoPatchelfHook
      ffmpeg
      nwjs
    ];

    buildInputs = [
      expat
      libXrandr
      libXfixes
      libXdamage
      libxcb
      libXcomposite
      cairo
      pango
      gtk3
      nss
      ffmpeg
      nwjs
    ];

    libPath = lib.makeLibraryPath [
      ffmpeg
      nwjs
    ];

    installPhase = ''
      install -m755 -D ${attrs.src}/open-lens $out/bin/${pname}

      install -Dm 644 ${attrs.src}/open-lens.desktop \
        $out/share/applications/${pname}.desktop

      install -Dm 644 ${attrs.src}/usr/share/icons/hicolor/512x512/apps/open-lens.png \
        $out/share/icons/hicolor/512x512/apps/${pname}.png

      substituteInPlace $out/share/applications/${pname}.desktop \
        --replace 'Icon=open-lens' 'Icon=${pname}' \
        --replace 'Exec=AppRun' 'Exec=${pname}'
    '';
  })
