{
  programs.nixvim.plugins = {
    none-ls = {
      sources = {
        formatting.alejandra.enable = true;
        diagnostics.statix.enable = true;
        code_actions.statix.enable = true;
      };
    };
    lsp = {
      servers = {
        nil_ls = {
          enable = true;
        };
      };
    };
  };
}

