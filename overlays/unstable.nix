channels: [
  (final: prev: {
    inherit (channels."nixpkgs-23.11") neovim-unwrapped;
  })
]
