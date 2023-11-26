{
  pkgs,
  config,
  lib,
  ...
}: {
  neovim = import ./neovim {inherit pkgs config lib;};
  alacritty = import ./alacritty {inherit pkgs config lib;};
  wezterm = import ./wezterm {inherit pkgs config lib;};
  tmux = import ./tmux {inherit pkgs config lib;};

  zsh = {
    enable = true;
    # enableSyntaxHighlighting = true;
    history = {
      share = true;
      ignoreDups = true;
      expireDuplicatesFirst = true;
    };

    localVariables = {
      ZSH_TMUX_AUTOSTART = true;
      ZSH_TMUX_CONFIG = "$HOME/.config/tmux/tmux.conf";
    };

    oh-my-zsh = {
      enable = true;
      plugins = ["git" "kubectx" "tmux"];
      theme = "robbyrussell";
    };
    zplug = {
      enable = true;
      plugins = [
        {
          name = "zsh-users/zsh-syntax-highlighting";
        }
      ];
    };
  };
  rofi = {
    enable = true;
    theme = "Arc-Dark";
    extraConfig = {
      show-icons = true;
      kb-cancel = "Alt+space,Escape";
    };
  };

  git = {
    enable = true;
    userName = "Denis Kaynar";
    userEmail = "kaynar.denis@gmail.com";
    extraConfig = {
      credential = {
        helper = "${pkgs.git.override {withLibsecret = true;}}/bin/git-credential-libsecret";
      };
      init = {
        defaultBranch = "master";
      };
      core = {
        autocrlf = "input";
      };
      pull = {
        rebase = false;
      };
    };
    lfs.enable = true;
    ignores = lib.splitString "\n" (builtins.readFile (builtins.fetchurl {
      url = "https://www.toptal.com/developers/gitignore/api/linux,windows,macos,jetbrains,jetbrains+all,jetbrains+iml,vim,visualstudio,visualstudiocode,rider,intellij,intellij+all,intellij+iml,pycharm,pycharm+all,pycharm+iml";
      name = "gitignore";
      sha256 = "sha256:00qj9fyhg9baajrrqd4hnr906wrzlvgk0vdphyfn1l02napdldwr";
    }));
  };

  direnv = {
    enable = true;
    enableZshIntegration = true;
    # nix-direnv.enable = true;
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

  # vscode = {
  #   enable = true;
  #   package = pkgs.vscode-fhsWithPackages (ps: with ps; [gcc gdb gnumake cmake]);
  # };
}
