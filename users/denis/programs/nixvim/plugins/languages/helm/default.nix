{
  programs.nixvim.plugins = {
    helm = {
      enable = true;
    };
    lsp = {
      servers = {
        helm_ls = {
          enable = true;
          settings = {
            # yamlls = {
            #   settings = {
            #     format.enable = true;
            #   };
            # };
          };
        };
      };
    };
  };
}

