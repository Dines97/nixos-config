{
  config,
  pkgs,
  ...
}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      {
        plugin = telescope-nvim;
        type = "lua";
        config = builtins.readFile ./telescope.lua;
      }
      telescope-fzf-native-nvim

      {
        plugin = nvim-neoclip-lua; # Clipboard manager
        type = "lua";
        config = builtins.readFile ./neoclip.lua; # Persistent need be activated separately
      }
      {
        #FIXME: Doesn't work for now
        plugin = sqlite-lua; # Required for clipboard manager for persistent clipboard
        # type = "lua";
        config = "let g:sqlite_clib_path = '${pkgs.sqlite.out}/lib/libsqlite3.so'";
        # config = "vim.g.sqlite_clib_path = '${pkgs.sqlite.out}/lib/libsqlite3.so'"; # sqlite3 is required by sqlite-lua
      }
    ];
    extraPackages = with pkgs; [
      # Telescope
      ripgrep
      fd

      sqlite # Required for neoclip
    ];
  };
}
