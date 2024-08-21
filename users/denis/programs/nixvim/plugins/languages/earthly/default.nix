{pkgs, ...}: {
  programs = {
    nixvim = {
      extraPackages = with pkgs; [
      ];
    };
    nixvim.plugins = {
      lsp = {
        postConfig = ''
          -- require'lspconfig'.earthlyls.setup{}
        '';
      };
    };
  };
}
