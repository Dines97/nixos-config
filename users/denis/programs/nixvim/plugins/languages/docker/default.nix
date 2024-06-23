{
  programs.nixvim.plugins = {
    lsp = {
      servers = {
        dockerls = {
          enable = true;
        };
        docker-compose-language-service = {
          enable = true;
        };
      };
    };
  };
}
