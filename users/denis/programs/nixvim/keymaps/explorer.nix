{
  config,
  lib,
  pkgs,
  ...
}: {
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
      {
        action = "<cmd>Neotree source=filesystem reveal=true position=left toggle=true<cr>";
        key = "<leader>eo";
        options.desc = "Open";
      }
      {
        action = "<cmd>Neotree source=filesystem reveal=true position=float toggle=true<cr>";
        key = "<leader>ef";
        options.desc = "Float";
      }
    ];
}
