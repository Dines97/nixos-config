{
  programs.nixvim.plugins = {
    lsp = {
      servers = {
        omnisharp = {
          enable = true;
        };
      };
    };
  };
}
