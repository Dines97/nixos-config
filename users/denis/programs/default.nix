{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    ./alacritty
    ./git
    ./neovim
    ./tmux
    ./wezterm
    ./zellij
    ./zsh
  ];

  programs = {
    command-not-found = {
      enable = false;
    };

    nix-index = {
      enable = true;
      enableZshIntegration = true;
    };

    nix-index-database = {
      comma = {
        enable = true;
      };
    };

    firefox = {
      enable = true;
      nativeMessagingHosts = [pkgs.gnome-browser-connector];
    };

    chromium = {
      enable = true;
    };

    rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      theme = "Arc-Dark";
      extraConfig = {
        show-icons = true;
        kb-cancel = "Alt+space,Escape";
      };
    };

    password-store = {
      enable = true;
    };

    direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    sioyek = {
      enable = true;
      config = {
        dark_mode_contrast = "0.7";
        page_separator_width = "8";
        page_separator_color = "0.5 0.5 0.5";
        custom_background_color = "0.81 0.81 0.75";
        custom_text_color = "0.09 0.09 0.09";
      };
    };

    gh = {
      enable = true;
      gitCredentialHelper = {
        enable = true;
      };
    };

    go.enable = true;

    hstr = {
      enable = true;
      enableZshIntegration = true;
    };

    # Just for large files
    vim = {
      enable = true;
    };

    # vscode = {
    #   enable = true;
    #   package = pkgs.vscode-fhsWithPackages (ps: with ps; [gcc gdb gnumake cmake]);
    # };

    helix = {
      enable = true;
    };

    gpg = {
      enable = true;
      mutableKeys = false;
      mutableTrust = false;
    };
  };

  services = {
    gpg-agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-gnome3;
    };
  };
}
