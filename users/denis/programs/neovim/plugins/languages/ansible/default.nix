{
  config,
  pkgs,
  ...
}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      nvim-ansible
    ];

    extraPackages = with pkgs; [
      # Ansible
      ansible-language-server
      ansible-lint
    ];
  };
}
