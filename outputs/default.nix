{
  self,
  channels,
  ...
}: let
  default = channels.nixpkgs-unstable;
in {
  # overlays = inputs.fup.lib.exportOverlays {inherit (self) pkgs inputs;};
  # packages = inputs.fup.lib.exportPackages self.overlays channels;

  packages.python-discord-bot-docker = default.pkgs.dockerTools.buildImage {
    name = "darktts";
    tag = "0.1.0";
    copyToRoot = self.devShells.x86_64-linux.python-discord-bot;
  };

  devShells = {
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
        cxx-rs

        (opencv.override {
          enableGtk3 = true;
          enableCuda = true;
          # enableCudnn = true;
        })
        (dlib.override {
          guiSupport = true;
          cudaSupport = true;

          # sse4Support = true;
          # avxSupport = true;
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

    random-python = default.mkShell {
      packages = with default.pkgs; [
        (pkgs.python3.withPackages (ps:
          with ps; [
            nextcord
            sqlalchemy
            google
            google-api-core
            google-cloud-texttospeech
            setuptools
            psycopg2

            pandas
            requests
            # other python packages
            fastapi
            uvicorn

            asgiref
            async-timeout
            certifi
            charset-normalizer
            click
            django
            idna
            importlib-metadata
            pysocks
            python-dotenv
            redis
            six
            spotipy
            sqlparse
            typing-extensions
            urllib3
            zipp
          ]))
      ];
    };
  };
}
