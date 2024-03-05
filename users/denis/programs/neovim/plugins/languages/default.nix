{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./ansible
    ./c
    ./csharp
    ./dockerls
    ./flutter
    ./go
    ./helm
    ./latex
    ./lua
    ./nix
    ./python
    ./rust
    ./terraform
    ./vue
    ./yaml
  ];

  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      {
        plugin = null-ls-nvim;
        type = "lua";
        config = builtins.readFile ./null-ls-nvim.lua;
      }
    ];

    extraPackages = with pkgs; [
      # Generic
      nodePackages.prettier
    ];
  };
}
