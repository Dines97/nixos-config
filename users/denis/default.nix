{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    ./gui
    ./programs

    ./cli.nix
    ./development.nix
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
    username = lib.mkDefault "denis";
    stateVersion = "24.05";

    sessionVariables = {
      LANG = "en_US.UTF-8";

      PAGER = "less";
      BROWSER = "firefox";
      EDITOR = "nvim";
      LESS = "-r --mouse";
      GOPATH = "$HOME/go";

      RUSTC_WRAPPER = "sccache";

      DOTNET_ROOT = "${pkgs.dotnet-sdk}/share/dotnet";
      DOTNET_CLI_UI_LANGUAGE = "en";
    };

    sessionPath = [
      "$HOME/.krew/bin"
      "$HOME/go/bin"
      "$HOME/.dotnet/tools"
    ];

    shellAliases = {
      o = "xdg-open";
      gs = "git status";
      gt = "git log --all --decorate --oneline --graph";
      reset = "clear";
      # reset = "clear; tmux clear-history";
      ls = "eza";
      ll = "eza --long --all --header --time-style=long-iso --git --icons --group-directories-first --group --binary";
      cat = "bat";
      k = "kubectl";
      spot = "spotify_player";
      cd = "z";

      nixupdate = "nix flake update --flake /etc/nixos && nh os switch /etc/nixos";
      nixswitch = "nh os switch /etc/nixos";

      hmupdate = "nh home switch --update ~/.config/home-manager";
      hmswitch = "nh home switch ~/.config/home-manager";

      # I am doing this way to much
      ":q" = "exit";

      nconf = "nvim $HOME/.config/nvim/";
      nixconf = "cd /etc/nixos && nvim /etc/nixos/";
      iconf = "nvim $HOME/.config/i3/";
      aconf = "nvim $HOME/.config/awesome/";
      hconf = "nvim $HOME/.config/hypr/";
    };
  };
}

