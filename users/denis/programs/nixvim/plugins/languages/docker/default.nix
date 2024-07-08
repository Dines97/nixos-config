{
  programs.nixvim.plugins = {
    none-ls = {
      sources = {
        diagnostics.hadolint.enable = true;
      };
    };
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
