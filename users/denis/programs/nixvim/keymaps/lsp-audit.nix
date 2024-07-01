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
      # LSP Audit
      {
        action = "<cmd>LspInfo<cr>";
        key = "<leader>Li";
        options.desc = "Info";
      }
      {
        action = "<cmd>LspStart<cr>";
        key = "<leader>Ls";
        options.desc = "Start";
      }
      {
        action = "<cmd>LspStop<cr>";
        key = "<leader>Lp";
        options.desc = "Stop";
      }
      {
        action = "<cmd>LspRestart<cr>";
        key = "<leader>Lr";
        options.desc = "Restart";
      }
    ];
}
