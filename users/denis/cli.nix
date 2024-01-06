{
  pkgs,
  config,
  ...
}: {
  home = {
    packages = with pkgs; [
      # Core

      # exa # unmaintained
      eza

      bat
      # ripgrep
      ncdu
      htop
      wget
      openssl
      ventoy-full

      # Hardware
      pciutils

      # NixOS
      cachix
      appimage-run
      nix-info
      nix-index
      fup-repl
    ];
  };
}
