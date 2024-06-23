{
  programs.nixvim.plugins = {
    lsp = {
      servers = {
        lua_ls = {
          enable = true;
          settings = {
            diagnostics = {
              globals = ["vim" "cmp" "luasnip"];
            };
            format = {
              enable = true;
              defaultConfig = {
                indent_style = "space";
                indent_size = "2";
                quote_style = "single";
                trailing_table_separator = "never";
              };
            };
          };
        };
      };
    };
  };
}
