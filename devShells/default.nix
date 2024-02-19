{channels, ...}: {
  rust = channels.nixpkgs.pkgs.mkShell {
    nativeBuildInputs = with channels.nixpkgs.pkgs; [
      rust-bin.stable.latest.default
    ];

    buildInputs = with channels.nixpkgs.pkgs; [
    ];
  };

  rust-cpp = channels.nixpkgs.pkgs.mkShell {
    nativeBuildInputs = with channels.nixpkgs.pkgs; [
      rust-bin.stable.latest.default
      rustPlatform.bindgenHook

      pkg-config
    ];

    buildInputs = with channels.nixpkgs.pkgs; [
      opencv
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

    # shellHook = ''
    #   export CARGO_HOME="${pkgs.cargo}/bin"
    # '';
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
