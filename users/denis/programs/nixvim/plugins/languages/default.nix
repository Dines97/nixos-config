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
    ./json
    ./jsonnet
    ./latex
    ./lua
    ./nix
    ./pest
    ./protobuf
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
          settings = {
            extra_filetypes = [
              "javascript"
              "javascriptreact"
              "typescript"
              "typescriptreact"
              "vue"
              "css"
              "scss"
              "less"
              "html"
              "json"
              "jsonc"
              "yaml"
              "markdown"
              "markdown.mdx"
              "graphql"
              "handlebars"
              "toml"
            ];
          };
        };
      };
    };

    lsp = {
      servers = {
        harper_ls = {
          enable = false;
          extraOptions = {
            linters = {
              SentenceCapitalization = false;
            };
          };
          settings = {
            linters = {
              SentenceCapitalization = false;
            };
          };
        };
      };
    };
  };
}

