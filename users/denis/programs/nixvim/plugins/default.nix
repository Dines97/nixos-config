{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./ai
    ./cmp
    ./editor
    ./keymaps
    ./languages
    ./lsp
    ./misc
    ./multiplexer
    ./telescope
    ./treesitter
    ./ui
  ];

  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      legendary-nvim
      pest-vim
      satellite-nvim
      # nvim-lsp-endhints
    ];

    extraConfigLua = builtins.readFile ./default.lua;

    plugins = {
      comment = {
        enable = true;
      };

      mini = {
        enable = true;
      };

      sqlite-lua = {
        enable = true;
      };
    };
  };
}

