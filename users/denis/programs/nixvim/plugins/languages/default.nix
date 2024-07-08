{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./ansible
    ./c
    ./csharp
    ./docker
    ./helm
    ./latex
    ./lua
    ./nix
    ./python
    ./rust
    ./terraform
    ./yaml
  ];
  programs.nixvim.plugins = {
    none-ls = {
      sources = {
        formatting.prettier = {
          enable = true;
          withArgs = ''
            { filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue', 'css', 'scss', 'less', 'html', 'json', 'jsonc', 'yaml', 'markdown', 'markdown.mdx', 'graphql', 'handlebars', 'toml' } }
          '';
        };
      };
    };
  };
}
