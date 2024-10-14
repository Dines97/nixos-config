{
  programs.nixvim.plugins = {
    # yaml-completion = {
    #   enable = true;
    # };
    schemastore = {
      yaml.enable = true;
    };
    lsp = {
      servers = {
        yamlls = {
          enable = true;
          # filetypes = [
          #   "yaml"
          #   "yaml.docker-compose"
          #   "yaml.gitlab"
          #   "helm"
          # ];
          settings = {
            format.enable = true;
          };
        };
      };
    };
  };
}

