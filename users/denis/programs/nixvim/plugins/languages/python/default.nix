{
  programs.nixvim.plugins = {
    none-ls = {
      sources = {
        formatting.isort.enable = true;
        formatting.black.enable = true;
      };
    };
    lsp = {
      servers = {
        pyright = {
          enable = true;
        };
      };
    };
  };
}
