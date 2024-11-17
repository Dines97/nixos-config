final: prev: {
  teams-for-poor-people = prev.makeDesktopItem {
    name = "Teams";
    desktopName = "Teams Web";
    exec = "${prev.chromium}/bin/chromium --app=\"https://teams.microsoft.com\"";
    icon = "teams";
    type = "Application";
    categories = ["Network" "InstantMessaging"];
    terminal = false;
    mimeTypes = ["x-scheme-handler/teams"];
  };

  vaapiIntel = prev.vaapiIntel.override {enableHybridCodec = true;};
  intel-vaapi-driver = prev.intel-vaapi-driver.override {enableHybridCodec = true;};

  awmtt = prev.callPackage ./awmtt {};
  aawmtt = prev.callPackage ./aawmtt {};

  remote-desktop-manager = prev.callPackage ./remote-desktop-manager {};

  asus-touchpad-numpad-driver = prev.callPackage ./asus-touchpad-numpad-driver {};

  # input-leap = prev.qt6Packages.callPackage ./input-leap {
  #   avahi = prev.avahi.override {withLibdnssdCompat = true;};
  # };

  # input-leap =
  #   (prev.input-leap.overrideAttrs (old: {
  #     version = "2024-03-25";
  #     src = prev.fetchFromGitHub {
  #       owner = "input-leap";
  #       repo = "input-leap";
  #       rev = "a1864cba75342ad289699b9ec56de28a957a6e54";
  #       hash = "sha256-ToOZ00WOL6nYBmshFt6WWneiX0+/2moP/KvuES37pgE=";
  #       fetchSubmodules = true;
  #     };
  #
  #     buildInputs = with prev;
  #       old.buildInputs
  #       ++ [
  #         libuuid
  #         libselinux
  #         libsepol
  #       ];
  #   }))
  #   .override {
  #     libportal = prev.libportal.overrideAttrs (old: {
  #       version = "2024-03-07";
  #       src = prev.fetchFromGitHub {
  #         owner = "flatpak";
  #         repo = "libportal";
  #         rev = "7c408fbaac7eaad5359a78083ac04cc2abd06674";
  #         hash = "sha256-R3v/+j9+8bYLjUhnE3qf0Rer+o9Co0oN8KY8nxGBBNY=";
  #         fetchSubmodules = true;
  #       };
  #
  #       nativeBuildInputs =
  #         old.nativeBuildInputs
  #         ++ [
  #           prev.qt6.qtbase
  #         ];
  #
  #       # propagatedBuildInputs =
  #       #   old.propagatedBuildInputs
  #       #   ++ [
  #       #     prev.qt6.qtbase
  #       #   ];
  #
  #       buildInputs = [
  #         prev.qt6.qtbase
  #       ];
  #     });
  #   };

  vimPlugins =
    prev.vimPlugins
    // {
      filetype-nvim = prev.vimUtils.buildVimPlugin {
        pname = "filetype.nvim";
        version = "2022-06-02";
        src = prev.fetchFromGitHub {
          owner = "nathom";
          repo = "filetype.nvim";
          rev = "b522628a45a17d58fc0073ffd64f9dc9530a8027";
          sha256 = "sha256-B+VvgQj8akiKe+MX/dV2/mdaaqF8s2INW3phdPJ5TFA=";
        };
        meta.homepage = "https://github.com/nathom/filetype.nvim";
      };

      hmts-nvim = prev.vimUtils.buildVimPlugin {
        pname = "hmts.nvim"; # Custom treesitter queries for Home Manager nix files, in Neovim
        version = "2023-08-28";
        src = prev.fetchFromGitHub {
          owner = "calops";
          repo = "hmts.nvim";
          rev = "14fd941d7ec2bb98314a1aacaa2573d97f1629ab";
          sha256 = "sha256-jUuztOqNBltC3axa7s3CPJz9Cmukfwkf846+Z/gAxCU=";
        };
        meta.homepage = "https://github.com/calops/hmts.nvim";
      };

      pets-nvim = prev.vimUtils.buildVimPlugin {
        pname = "pets.nvim";
        version = "2024-01-03";
        src = prev.fetchFromGitHub {
          owner = "giusgad";
          repo = "pets.nvim";
          rev = "94b4724e031fc3c9b6da19bdef574f44fabcca16";
          sha256 = "sha256-CtBCiTo26cTU+q/67QSrondNeyoAdVuIXMHZnxHMIm4=";
        };
        meta.homepage = "https://github.com/giusgad/pets.nvim/";
      };

      yaml-companion-nvim = prev.vimUtils.buildVimPlugin {
        pname = "yaml-companion.nvim";
        version = "2023-03-04";
        src = prev.fetchFromGitHub {
          owner = "someone-stole-my-name";
          repo = "yaml-companion.nvim";
          rev = "4de1e1546abc461f62dee02fcac6a02debd6eb9e";
          sha256 = "sha256-BmX7hyiIMQfcoUl09Y794HrSDq+cj93T+Z5u3e5wqLc=";
        };
        meta.homepage = "https://github.com/someone-stole-my-name/yaml-companion.nvim/";
      };

      nvim-ansible = prev.vimUtils.buildVimPlugin {
        pname = "nvim-ansible";
        version = "2023-03-15";
        src = prev.fetchFromGitHub {
          owner = "mfussenegger";
          repo = "nvim-ansible";
          rev = "d115cb9bb3680c990e2684f58cf333663fff03b8";
          sha256 = "sha256-mh//2sfwjEtYm95Ihnvv6vy3iW6d8xinkX1uAsNFV7E=";
        };
        meta.homepage = "https://github.com/mfussenegger/nvim-ansible";
      };

      workspace-diagnostics-nvim = prev.vimUtils.buildVimPlugin {
        pname = "workspace-diagnostics-nvim";
        version = "2024-02-16";
        src = prev.fetchFromGitHub {
          owner = "artemave";
          repo = "workspace-diagnostics.nvim";
          rev = "d0110dd1f6c4e4a121d6b3332ac4af6f99282ea5";
          sha256 = "sha256-ggUFFiR2N+ntkd2HqQU8bcgdhNgKSHj3nnmPMY8o19s=";
        };
        meta.homepage = "https://github.com/artemave/workspace-diagnostics.nvim";
      };

      nvim-nio = prev.vimUtils.buildVimPlugin {
        pname = "nvim-nio";
        version = "2024-04-04";
        src = prev.fetchFromGitHub {
          owner = "nvim-neotest";
          repo = "nvim-nio";
          rev = "5800f585def265d52f1d8848133217c800bcb25d";
          sha256 = "sha256-ZRYclqsgAvlRBwb59XHlqVat7CxUJTH1rD6QLwh1ang=";
        };
        meta.homepage = "https://github.com/nvim-neotest/nvim-nio";
      };

      nvim-lsp-endhints = prev.vimUtils.buildVimPlugin {
        pname = "nvim-lsp-endhints";
        version = "2024-07-04";
        src = prev.fetchFromGitHub {
          owner = "chrisgrieser";
          repo = "nvim-lsp-endhints";
          rev = "3a259c593bcd90f5a9b88e1803656c2cea0f3da1";
          sha256 = "sha256-et8nebIP76PqsGsWpTjOwLaD9wcOqqZyDa++vuQpWco=";
        };
        meta.homepage = "https://github.com/chrisgrieser/nvim-lsp-endhints";
      };

      kubectl-nvim = prev.vimUtils.buildVimPlugin {
        pname = "kubectl-nvim";
        version = "2024-10-27";
        src = prev.fetchFromGitHub {
          owner = "Ramilito";
          repo = "kubectl.nvim";
          rev = "23e01f316900cae29bdbb21c8cd92bb9fc8c7eb9";
          sha256 = "sha256-7iJ7tkOXSdPRdAYkXl9yYkwp2DaJ37cXHdSJH6PAQiE=";
        };
        meta.homepage = "https://github.com/Ramilito/kubectl.nvim";
      };
    };

  tmuxPlugins =
    prev.tmuxPlugins
    // {
      open = prev.tmuxPlugins.mkTmuxPlugin {
        pluginName = "open";
        version = "2022-08-22";
        src = prev.fetchFromGitHub {
          owner = "tmux-plugins";
          repo = "tmux-open";
          rev = "763d0a852e6703ce0f5090a508330012a7e6788e";
          hash = "sha256-Thii7D21MKodtjn/MzMjOGbJX8BwnS+fQqAtYv8CjPc=";
        };
      };

      suspend = prev.tmuxPlugins.mkTmuxPlugin {
        pluginName = "suspend";
        version = "2023-01-15";
        src = prev.fetchFromGitHub {
          owner = "MunifTanjim";
          repo = "tmux-suspend";
          rev = "1a2f806666e0bfed37535372279fa00d27d50d14";
          hash = "sha256-+1fKkwDmr5iqro0XeL8gkjOGGB/YHBD25NG+w3iW+0g=";
        };
      };
    };
}

