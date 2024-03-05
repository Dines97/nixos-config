{channels, ...}: let
  default = channels.nixpkgs-unstable;
in {
  linux-hello-cpp = default.pkgs.mkShell {
    nativeBuildInputs = with default.pkgs; [
      cmake
      pkg-config
    ];

    buildInputs = with default.pkgs; [
      (opencv.override {enableGtk3 = true;})
      (dlib.override {
        guiSupport = true;

        sse4Support = true;
        avxSupport = true;

        cudaSupport = true;
      })
      blas
      lapack
      # openssl
      cereal
      pam
    ];
  };

  rust = default.pkgs.mkShell {
    nativeBuildInputs = with default.pkgs; [
      rust-bin.stable.latest.default
      rustPlatform.bindgenHook
    ];

    buildInputs = with default.pkgs; [
    ];
  };

  linux-hello = default.pkgs.mkShell {
    nativeBuildInputs = with default.pkgs; [
      rust-bin.stable.latest.default
      cargo-flamegraph

      rustPlatform.bindgenHook

      cmake
      pkg-config
    ];

    buildInputs = with default.pkgs; [
      (opencv.override {enableGtk3 = true;})
      (dlib.override {
        guiSupport = true;

        sse4Support = true;
        avxSupport = true;

        cudaSupport = true;
      })

      # opencv
      # dlib

      blas
      lapack
      xorg.libX11.dev
      # cudatoolkit
    ];
  };

  node20 = default.mkShell {
    nativeBuildInputs = with default.pkgs; [
      nodejs_20

      # JavaScript
      # bun
      # typescript # For volar in neovim to use
    ];
  };

  bun = default.mkShell {
    nativeBuildInputs = with default.pkgs; [
      nodejs_20 # Required for .npmrc auth

      bun
    ];
  };

  python-discord-bot = default.mkShell {
    packages = with default.pkgs; [
      (python3.withPackages (ps:
        with ps; [
          nextcord
          sqlalchemy
          google-cloud-texttospeech
          setuptools
          psycopg2
        ]))
    ];
  };
}
