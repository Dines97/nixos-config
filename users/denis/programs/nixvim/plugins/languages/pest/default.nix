{
  programs.nixvim.plugins = {
    lsp = {
      servers = {
        pest_ls = {
          enable = true;
        };
      };
    };
  };
}

