{channels, ...}: {
  linux-hello-cpp = channels.nixpkgs.pkgs.mkShell {
    nativeBuildInputs = with channels.nixpkgs.pkgs; [
      cmake
      pkg-config
    ];

    buildInputs = with channels.nixpkgs.pkgs; [
      (opencv.override {enableGtk3 = true;})
      (dlib.override {guiSupport = true;})
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
      rustPlatform.bindgenHook

      pkg-config
    ];

    buildInputs = with channels.nixpkgs.pkgs; [
      (opencv.override {enableGtk3 = true;})
      (dlib.override {guiSupport = true;})
      blas
      lapack
      openssl
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
