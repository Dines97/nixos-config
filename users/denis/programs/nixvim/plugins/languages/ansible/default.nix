{pkgs, ...}: {
  programs.nixvim = {
    extraPackages = with pkgs; [
      ansible-lint
      python3
    ];

    plugins = {
      lsp = {
        servers = {
          ansiblels = {
            enable = true;
          };
        };
      };
    };
  };
}
