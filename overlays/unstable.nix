channels: [
  (final: prev: {
    inherit (channels.nixpkgs) etcher vagrant;
  })
]
