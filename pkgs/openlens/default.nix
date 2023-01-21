{
  lib,
  fetchurl,
  appimageTools,
  wrapGAppsHook,
  nss,
}: let
  pname = "openlens";
  version = "6.3.0";

  owner = "beliys";
  repo = "OpenLens";

  src = fetchurl {
    url = " https://github.com/${owner}/${repo}/releases/download/v${version}/OpenLens-${version}.x86_64.AppImage";
    sha256 = "sha256-72qzswHlSk33zPUN1Wa7vcEYc3CERVAAjGsIlhU6AlM=";
  };

  appimageContents = appimageTools.extractType2 {inherit src pname version;};
in
  appimageTools.wrapType2 {
    inherit src pname version;

    extraPkgs = pkgs: appimageTools.defaultFhsEnvArgs.multiPkgs pkgs ++ [nss];

    extraInstallCommands = ''
      mv $out/bin/${pname}-${version} $out/bin/${pname}

      install -Dm 644 ${appimageContents}/open-lens.desktop \
        $out/share/applications/${pname}.desktop

      install -Dm 644 ${appimageContents}/usr/share/icons/hicolor/512x512/apps/open-lens.png \
        $out/share/icons/hicolor/512x512/apps/${pname}.png

      substituteInPlace $out/share/applications/${pname}.desktop \
        --replace 'Icon=open-lens' 'Icon=${pname}' \
        --replace 'Exec=AppRun' 'Exec=${pname}'
    '';

    meta = with lib; {
      description = "The Kubernetes IDE";
      homepage = "https://k8slens.dev/";
      license = licenses.mit;
      maintainers = with maintainers; [dbirks];
      platforms = ["x86_64-linux"];
    };
  }
