channels: [
  (final: prev: {
    inherit (channels.nixpkgs-unstable) helm-ls eza bun input-leap git-credential-manager;
    vimPlugins =
      prev.vimPlugins
      // {
        inherit (channels.nixpkgs-unstable.vimPlugins) vim-helm indent-blankline-nvim;
      };
  })
]
