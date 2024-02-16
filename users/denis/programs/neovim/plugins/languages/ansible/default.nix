{
  config,
  pkgs,
  ...
}: {
  programs.neovim = {
    extraLuaConfig = builtins.readFile ./default.lua;

    plugins = with pkgs.vimPlugins; [
      nvim-ansible # Filetype plugin for ansible
    ];

    extraPackages = with pkgs; [
      # Ansible
      ansible-language-server
      ansible-lint # Used by ansible-language-server
    ];
  };
}
