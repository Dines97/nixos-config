{
  config,
  pkgs,
  ...
}: {
  programs.nixvim.plugins = {
    which-key = {
      enable = true;
      registrations = {
        "<leader>" = {
          l = "LSP";
          L = "LSP audit";
          r = "Trouble";
          w = "Workspace";
          d = "Diagnostic";
          t = "Telescope";
          e = "Explorer";
        };
      };
    };

    # legendary = {
    #   enable = true;
    #   settings = {
    #     extensions = {
    #       smart_splits = true;
    #     };
    #     # keymaps = [
    #     #   {
    #     #     key = "<S-h>";
    #     #     action = "<cmd>BufferPrevious<cr>";
    #     #   }
    #     #   {
    #     #     key = "<S-l>";
    #     #     action = "<cmd>BufferNext<cr>";
    #     #   }
    #     # ];
    #   };
    # };
  };
}
