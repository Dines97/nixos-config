{
  lib,
  stdenv,
  fetchFromGitHub,
  fetchYarnDeps,
  nodejs-16_x,
  yarn,
  fixup_yarn_lock,
  cacert,
}: let
  yarn' = yarn.override {nodejs = nodejs-16_x;};
in
  stdenv.mkDerivation rec {
    pname = "openlens";
    version = "6.3.0";

    src = fetchFromGitHub {
      owner = "lensapp";
      repo = "lens";
      rev = "v${version}";
      sha256 = "sha256-nxHkslWhxDEVL4aUCVpd8sKL7QqZKJMTK+gDJFX+PuM=";
    };

    yarnCache = stdenv.mkDerivation {
      name = "${pname}-${version}-yarn-cachre";
      inherit src;
      nativeBuildInputs = [cacert yarn' fixup_yarn_lock];
      buildPhase = ''
        export HOME=$PWD

        yarn config set yarn-offline-mirror $out
        yarn install --check-files --frozen-lockfile \
            --ignore-scripts --ignore-platform \
            --ignore-engines --no-progress --non-interactive
      '';

      outputHashMode = "recursive";
      outputHashAlgo = "sha256";
      outputHash = "sha256-7UBXigQj7c+fuHPIM5BbRe02DuL+cs6VbQ/D84Yk8i5=";
    };

    buildInputs = [nodejs-16_x];

    configurePhase = ''
      runHook preConfigure

      yarn install --offline --check-files --frozen-lockfile
      patchShebangs node_modules/

      runHook postConfigure
    '';
  }
