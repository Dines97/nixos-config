{
  programs.nixvim.plugins = {
    lsp = {
      servers = {
        clangd = {
          enable = true;
          filetypes = [
            "c"
            "cpp"
            "objc"
            "objcpp"
            "cuda"
          ];
        };
      };
    };
  };
}
