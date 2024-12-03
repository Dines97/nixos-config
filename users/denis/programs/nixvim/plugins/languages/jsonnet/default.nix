{
  programs.nixvim.plugins = {
    lsp = {
      servers = {
        jsonnet_ls = {
          enable = true;
        };
      };
    };
  };
}

