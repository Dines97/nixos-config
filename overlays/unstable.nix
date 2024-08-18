channels: [
  (final: prev: {
    zerotierone = prev.zerotierone.override {inherit (channels."nixpkgs-24.05") rustPlatform rustc;};
    wezterm = prev.wezterm.override {inherit (channels."nixpkgs-24.05") rustPlatform;};
  })
]
