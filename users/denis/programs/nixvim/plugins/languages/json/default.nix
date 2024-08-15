{
  programs.nixvim.plugins = {
    schemastore = {
      json.enable = true;
    };
    lsp = {
      servers = {
        jsonls = {
          enable = true;
        };
      };
    };
  };
}
