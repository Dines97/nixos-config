final: prev: {
  vaapiIntel = prev.vaapiIntel.override {enableHybridCodec = true;};
  intel-vaapi-driver = prev.intel-vaapi-driver.override {enableHybridCodec = true;};

  awmtt = prev.callPackage ./awmtt {};
  aawmtt = prev.callPackage ./aawmtt {};

  remote-desktop-manager = prev.callPackage ./remote-desktop-manager {};

  wezterm = prev.wezterm.overrideAttrs (old: {
    postInstall =
      old.postInstall
      + ''
        substituteInPlace $out/share/applications/org.wezfurlong.wezterm.desktop --replace \
        "Exec=wezterm start --cwd ." \
        "Exec=wezterm"
      '';
  });

  input-leap = prev.input-leap.overrideAttrs (old: {
    version = "2023-11-21";
    src = prev.fetchFromGitHub {
      owner = "input-leap";
      repo = "input-leap";
      rev = "3e681454b737633a70f2f3b789046a5cb1946708";
      hash = "sha256-OZMVz075oC7UQI7F9uDz8F6eBr1WN4aYxLFq9bc3M6g=";
      fetchSubmodules = true;
    };
  });

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
        version = "2023-08-06";
        src = prev.fetchFromGitHub {
          owner = "calops";
          repo = "hmts.nvim";
          rev = "c1a94724b2b343861031fe3a320d5ee3cb8d5167";
          sha256 = "sha256-lZs6MloTZ81fKFllOW7VTMW3F0gZPtajh7m3vfA9Tiw=";
        };
        meta.homepage = "https://github.com/calops/hmts.nvim";
      };

      pets-nvim = prev.vimUtils.buildVimPlugin {
        pname = "pets.nvim";
        version = "2023-03-15";
        src = prev.fetchFromGitHub {
          owner = "giusgad";
          repo = "pets.nvim";
          rev = "8200520815038a57787d129cc30f9a7575b6802b";
          sha256 = "sha256-obdjCiNyFCGz8Z6eWPL3nQ+kAAwqfbwbpWmMiABCFHw=";
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
    };
}
