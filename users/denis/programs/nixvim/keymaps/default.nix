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

  programs.nixvim.keymaps =
    lib.lists.map (x:
      lib.attrsets.recursiveUpdate {
        mode = ["n"];
        options = {
          silent = true;
          noremap = true;
          nowait = true;
        };
      }
      x)
    [
    ];
}
