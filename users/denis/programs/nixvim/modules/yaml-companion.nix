{
  lib,
  helpers,
  config,
  pkgs,
  ...
}:
helpers.neovim-plugin.mkNeovimPlugin config {
  name = "yaml-companion";
  originalName = "yaml-companion.nvim ";
  defaultPackage = pkgs.vimPlugins.yaml-companion-nvim;

  # maintainers = [
  #   {
  #     name = "Denis Kaynar";
  #     email = "19364873+Dines97@users.noreply.github.com";
  #     github = "Dines97";
  #     githubId = 19364873;
  #   }
  # ];

  settingsOptions = {
  };

  extraConfig = cfg: {
    plugins = {
      nvim-lspconfig.enable = true;
      plenary.enable = true;
      telescope.enable = true;
    };
  };

  # extraConfig = cfg:
  #   lib.mkMerge [
  #     {
  #       plugins.lsp = {
  #         preConfig = ''
  #           local aaaaaaaaaaaa = "Hello there";
  #         '';
  #       };
  #     }
  #     # Dependency
  #     {plugins.nvim-lspconfig.enable = true;}
  #     {plugins.plenary.enable = true;}
  #     {plugins.telescope.enable = true;}
  #   ];
}
