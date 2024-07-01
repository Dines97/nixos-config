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
      # Telescope
      {
        action.__raw = "require('telescope.builtin').find_files";
        key = "<leader>tf";
        options.desc = "Files";
      }
      {
        action.__raw = "require('telescope.builtin').live_grep";
        key = "<leader>tg";
        options.desc = "Grep";
      }
      {
        action.__raw = "require('telescope.builtin').buffers";
        key = "<leader>tb";
        options.desc = "Buffers";
      }
      {
        action = "<cmd>Telescope neoclip<cr>";
        key = "<leader>tn";
        options.desc = "Neoclip";
      }
    ];
}
