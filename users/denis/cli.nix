{
  pkgs,
  config,
  inputs,
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

      # nix-output-monitor
      # nh
      inputs.nom.packages."x86_64-linux".default
      inputs.nh.packages."x86_64-linux".default

      neofetch
      onefetch
    ];
  };
}
