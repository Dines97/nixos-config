{
  programs.nixvim.plugins = {
    crates = {
      enable = true;
    };
    rustaceanvim = {
      enable = true;
      settings = {
        server = {
          default_settings = {
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

