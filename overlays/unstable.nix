channels: [
  (final: prev: {
    zerotierone = prev.zerotierone.override {inherit (channels."nixpkgs-24.05") rustPlatform rustc;};
    inherit (channels."nixpkgs-master") vscode-langservers-extracted;
  })
]
