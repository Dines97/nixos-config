{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./ansible
    ./csharp
    ./flutter
    ./go
    ./helm
    ./latex
    ./nix
  ];
}
