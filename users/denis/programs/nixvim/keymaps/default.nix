{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./explorer.nix
    ./lsp-audit.nix
    ./telescope.nix
  ];

  # nnoremap Y "+y$
  programs.nixvim.keymaps = [
    {
      key = "Y";
      action = "\"+y";
    }
    {
      key = "P";
      action = "\"+p";
    }
  ];
}
