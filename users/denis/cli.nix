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
      xdg-utils
      sshpass

      # Hardware
      pciutils

      # NixOS
      cachix
      appimage-run
      nix-info
      fup-repl
    ];
  };
}
