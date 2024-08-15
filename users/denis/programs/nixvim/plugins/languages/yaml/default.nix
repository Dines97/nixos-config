{
  programs.nixvim.plugins = {
    # yaml-completion = {
    #   enable = true;
    # };
    schemastore = {
      yaml.enable = true;
    };
    lsp = {
      preConfig = ''
        local aaaaaaaaaaaa = "Hello there";
      '';
    };
    lsp = {
      servers = {
        yamlls = {
          enable = true;
          settings = {
            format.enable = true;
          };
        };
      };
    };
  };
}
