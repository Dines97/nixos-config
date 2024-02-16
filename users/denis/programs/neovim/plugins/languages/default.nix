{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./ansible
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
    ];

    extraPackages = with pkgs; [
      {
        plugin = null-ls-nvim;
        type = "lua";
        config = builtins.readFile ./null-ls-nvim.lua;
      }
    ];
  };
}
