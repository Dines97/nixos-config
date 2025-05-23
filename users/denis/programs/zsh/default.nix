{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    history = {
      share = true;
      ignoreDups = true;
      ignoreAllDups = true;
      expireDuplicatesFirst = true;
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        # "kubectx"
        "kube-ps1"
      ];
      theme = "robbyrussell";
    };

    initContent = ''
      RPS1='$(kube_ps1)'
    '';

    zplug = {
      enable = true;
      plugins = [
        {
          name = "zsh-users/zsh-syntax-highlighting";
          tags = ["as:plugin"];
        }
        # {
        #   name = "dracula/zsh";
        #   tags = ["as:theme"];
        # }
      ];
    };
  };
}

