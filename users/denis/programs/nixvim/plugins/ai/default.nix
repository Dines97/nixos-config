{
  config,
  pkgs,
  ...
}: {
  programs.nixvim = {
    plugins = {
      copilot-lua = {
        enable = true;
        filetypes = {
          "*" = true;
        };

        panel = {
          enabled = false;
        };
        suggestion = {
          enabled = false;
        };
      };

      copilot-cmp = {
        enable = true;
      };
    };
  };
}
