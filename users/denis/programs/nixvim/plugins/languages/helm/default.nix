{
  programs.nixvim.plugins = {
    lsp = {
      servers = {
        helm-ls = {
          enable = true;
        };
      };
    };
  };
}
