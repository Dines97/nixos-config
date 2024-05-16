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

      # Hardware
      pciutils

      # NixOS
      cachix
      appimage-run
      nix-info
      fup-repl

      # nix-output-monitor
      # nh
      (inputs.nom.packages."x86_64-linux".default)
      (inputs.nh.packages."x86_64-linux".default)

      onefetch
    ];
  };
}
