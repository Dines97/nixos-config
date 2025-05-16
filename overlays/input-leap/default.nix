{
  lib,
  stdenv,
  fetchFromGitHub,
  fetchpatch2,
  cmake,
  withLibei ? true,
  avahi,
  curl,
  libICE,
  libSM,
  libX11,
  libXdmcp,
  libXext,
  libXinerama,
  libXrandr,
  libXtst,
  libei,
  libportal,
  openssl,
  pkg-config,
  qtbase,
  qttools,
  wrapGAppsHook3,
  wrapQtAppsHook,
}:
stdenv.mkDerivation rec {
  pname = "input-leap";
  version = "2025-04-26";

  src = fetchFromGitHub {
    owner = "input-leap";
    repo = "input-leap";
    rev = "3b4a6c9f494223a2b74b43a97cc80bb181e3a3d4";
    hash = "sha256-AF+7UNWs2aUoONZiV0arBeMuf6KEE3YugWa3NgWE/yc=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    pkg-config
    cmake
    wrapGAppsHook3
    wrapQtAppsHook
    qttools
  ];
  buildInputs =
    [
      curl
      qtbase
      avahi
      libX11
      libXext
      libXtst
      libXinerama
      libXrandr
      libXdmcp
      libICE
      libSM
    ]
    ++ lib.optionals withLibei [
      libei
      libportal
    ];

  # patches = [
  #   (fetchpatch2 {
  #     # Upstream fix for crash on qt6.8 https://github.com/input-leap/input-leap/issues/2067
  #     url = "https://github.com/input-leap/input-leap/commit/2641bc502e16b1fb7372b43e94d4b894cbc71279.patch?full_index=1";
  #     hash = "sha256-LV09ITcE0ihKMByM5wiRetGwKbPrJbVY6HjZLqa8Dcs=";
  #   })
  # ];

  cmakeFlags =
    [
      "-DINPUTLEAP_REVISION=${builtins.substring 0 8 src.rev}"
    ]
    ++ lib.optional withLibei "-DINPUTLEAP_BUILD_LIBEI=ON";

  dontWrapGApps = true;
  preFixup = ''
    qtWrapperArgs+=(
      "''${gappsWrapperArgs[@]}"
        --prefix PATH : "${lib.makeBinPath [openssl]}"
    )
  '';

  postFixup = ''
    substituteInPlace $out/share/applications/io.github.input_leap.input-leap.desktop \
      --replace "Exec=input-leap" "Exec=$out/bin/input-leap"
  '';

  meta = {
    description = "Open-source KVM software";
    longDescription = ''
      Input Leap is software that mimics the functionality of a KVM switch, which historically
      would allow you to use a single keyboard and mouse to control multiple computers by
      physically turning a dial on the box to switch the machine you're controlling at any
      given moment. Input Leap does this in software, allowing you to tell it which machine
      to control by moving your mouse to the edge of the screen, or by using a keypress
      to switch focus to a different system.
    '';
    homepage = "https://github.com/input-leap/input-leap";
    license = lib.licenses.gpl2Plus;
    maintainers = with lib.maintainers; [
      kovirobi
      phryneas
      twey
      shymega
    ];
    platforms = lib.platforms.linux;
  };
}

