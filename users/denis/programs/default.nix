{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./alacritty
    ./fish
    ./git
    ./k9s
    ./nixvim
    ./tmux
    ./wezterm
    ./zellij
    ./zsh
  ];

  programs = {
    lan-mouse = {
      enable = true;
      systemd = false;
      # package = pkgs.lan-mouse;
      package = inputs.lan-mouse.packages.${pkgs.stdenv.hostPlatform.system}.default;
    };
    # beets = {
    #   enable = true;
    #   settings = {
    #     import = {
    #       write = "yes"; # Wrtie metadata
    #
    #       copy = "yes"; # Copy instead of move
    #       move = "no"; # " "
    #     };
    #   };
    # };

    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

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

      profiles = {
        "denis" = {
          id = 0;
          isDefault = true;

          # userChrome = builtins.readFile (builtins.fetchurl {
          #   url = "https://raw.githubusercontent.com/MrOtherGuy/firefox-csshacks/refs/heads/master/chrome/window_control_force_linux_system_style.css";
          #   sha256 = "sha256:18289pgf5g5g7cqd7zx5p6za0nf6cvpsy2wbjpgi2p0h525i8313";
          # });
          extraConfig = ''
            user_pref("browser.uidensity", 1);
            user_pref("ui.key.menuAccessKeyFocuses", false);
          '';
        };
      };
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

    go = {
      enable = true;
    };
  };

  services = {
    gpg-agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-gnome3;
    };

    spotifyd = {
      enable = true;
      # package = pkgs.spotifyd.override {withKeyring = true;};
    };
  };
}

