{channels, ...}: {
  linux-hello-cpp = channels.nixpkgs.pkgs.mkShell {
    nativeBuildInputs = with channels.nixpkgs.pkgs; [
      cmake
      pkg-config
    ];

    buildInputs = with channels.nixpkgs.pkgs; [
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

  rust = channels.nixpkgs.pkgs.mkShell {
    nativeBuildInputs = with channels.nixpkgs.pkgs; [
      rust-bin.stable.latest.default
      rustPlatform.bindgenHook
    ];

    buildInputs = with channels.nixpkgs.pkgs; [
    ];
  };

  linux-hello = channels.nixpkgs.pkgs.mkShell {
    nativeBuildInputs = with channels.nixpkgs.pkgs; [
      rust-bin.stable.latest.default
      cargo-flamegraph

      rustPlatform.bindgenHook

      pkg-config
    ];

    buildInputs = with channels.nixpkgs.pkgs; [
      (opencv.override {enableGtk3 = true;})
      (dlib.override {guiSupport = true;})
      blas
      lapack
      openssl

      xorg.libX11.dev

      xorg.libX11
      xorg.libXcursor
      xorg.libXrandr
      xorg.libXi

      shaderc
      directx-shader-compiler
      libGL
      vulkan-headers
      vulkan-loader
      vulkan-tools
      vulkan-tools-lunarg
      vulkan-validation-layers
    ];
  };

  python-discord-bot = channels.nixpkgs.mkShell {
    packages = with channels.nixpkgs.pkgs; [
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
