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
      inetutils
      openssl
      ventoy-full
      xdg-utils
      sshpass
      # pinentry
      gitoxide # Git cli written in rust
      dig # DNS utils
      spotify-player
      ncspot
      # spotify-tui

      # Hardware
      pciutils

      # NixOS
      cachix
      appimage-run
      nix-info
      fup-repl
      nh

      neofetch
      onefetch
    ];
  };
}
