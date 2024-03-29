{
  config,
  pkgs,
  ...
}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      {
        plugin = crates-nvim;
        type = "lua";
        config = "require('crates').setup()";
      }
      {
        plugin = rustaceanvim;
        type = "lua";
        config = builtins.readFile ./rustaceanvim.lua;
      }
    ];
    extraPackages = with pkgs; [
      graphviz # Crate graph

      rust-analyzer

      # lldb # For debugging
      vscode-extensions.vadimcn.vscode-lldb.adapter
    ];
  };
}
