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
        docker_compose_language_service = {
          enable = true;
        };
      };
    };
  };
}

