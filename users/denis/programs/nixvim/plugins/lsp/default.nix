{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.nixvim = {
    plugins = {
      none-ls = {
        enable = true;
      };

      schemastore = {
        enable = true;
      };

      lsp = {
        enable = true;
        inlayHints = true;
      };
      trouble = {
        enable = true;
      };

      # LSP context in win bar
      navic = {
        enable = true;
        settings = {
          lsp = {
            auto_attach = true;
          };
        };
      };

      # Code actions as light bulb
      nvim-lightbulb = {
        enable = true;
        settings = {
          autocmd = {
            enabled = true;
          };

          # sign = {
          #   enabled = false;
          # };
          #
          # virtual_text = {
          #   enabled = true;
          # };
        };
      };
    };
  };
}

