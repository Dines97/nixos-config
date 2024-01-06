{
  pkgs,
  config,
  lib,
  osConfig,
  ...
}: {
  imports = [
    ./programs
    ./cli.nix
    ./development.nix
    ./gui.nix
    ./work.nix
  ];

  # dconf = {
  #   settings = {
  #     "org/gnome/desktop/input-sources" = {
  #       xkb-options = [
  #         "grp:alt_shift_toggle"
  #         "caps:none"
  #       ];
  #     };
  #   };
  # };

  # wayland.windowManager.sway = {
  #   enable = true;
  #   config = rec {
  #     modifier = "Mod4";
  #     # Use kitty as default terminal
  #     terminal = "alacritty";
  #     startup = [
  #       # Launch Firefox on start
  #       {command = "firefox";}
  #     ];
  #   };
  # };

  home = {
    username = "denis";
    stateVersion = "23.11";

    sessionVariables = {
      PAGER = "less";
      EDITOR = "nvim";
      LESS = "-r --mouse";
      GOPATH = "$HOME/go";

      DOTNET_CLI_UI_LANGUAGE = "en";
      LANG = "en_US.UTF-8";
    };

    sessionPath = [
      "$HOME/.krew/bin"
    ];

    shellAliases = {
      o = "xdg-open";
      gs = "git status";
      gt = "git log --all --decorate --oneline --graph";
      reset = "clear; tmux clear-history";
      ls = "eza";
      ll = "eza --long --all --header --time-style=long-iso --git --icons --group-directories-first --group -b";
      cat = "bat";
      nixrebuild = "sudo nix flake update --flake /etc/nixos && sudo nixos-rebuild switch";

      nconf = "nvim $HOME/.config/nvim/";
      nixconf = "cd /etc/nixos && nvim /etc/nixos/";
      iconf = "nvim $HOME/.config/i3/";
      aconf = "nvim $HOME/.config/awesome/";
      hconf = "nvim $HOME/.config/hypr/";
    };

    packages = with pkgs; [
      # Xmonad
      # haskellPackages.xmobar
      # feh

      # xdotool
      # gnupg
      # pinentry
    ];
  };
}
