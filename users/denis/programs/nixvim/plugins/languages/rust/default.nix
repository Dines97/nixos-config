{
  programs.nixvim.plugins = {
    crates-nvim = {
      enable = true;
    };
    rustaceanvim = {
      enable = true;
      settings = {
        server = {
          settings = {
            rust-analyzer = {
              procMacro = {
                enable = true;
                attributes = {
                  enable = true;
                };
              };
            };
          };
        };
      };
    };
  };
}
