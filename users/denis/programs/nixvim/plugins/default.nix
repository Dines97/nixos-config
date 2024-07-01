{
  config,
  pkgs,
  ...
}: {
  imports = [
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
    ];

    extraConfigLua = builtins.readFile ./legendary.lua;

    plugins = {
      comment = {
        enable = true;
      };

      mini = {
        enable = true;
        modules = {
          move = {};
          trailspace = {};
        };
      };
    };
  };
}
