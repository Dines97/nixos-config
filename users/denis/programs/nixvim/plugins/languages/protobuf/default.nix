{
  programs.nixvim.plugins = {
    lsp = {
      servers = {
        bufls = {
          enable = true;
        };
      };
    };
  };
}
