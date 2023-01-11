{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.hstr;
in {
  options.programs.hstr = {
    enable = mkEnableOption "bash and zsh shell history suggest box - easily view, navigate, search and manage your command history. ";

    package = mkOption {
      type = types.package;
      default = pkgs.hstr;
      defaultText = literalExpression "pkgs.hstr";
      description = "Package providing the <command>hstr</command> tool.";
    };

    enableBashIntegration = mkOption {
      default = true;
      type = types.bool;
      description = ''
        Whether to enable Bash integration.
      '';
    };

    enableZshIntegration = mkOption {
      default = true;
      type = types.bool;
      description = ''
        Whether to enable Zsh integration.
      '';
    };

    enableFishIntegration = mkOption {
      default = true;
      type = types.bool;
      description = ''
        Whether to enable Fish integration.
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = [cfg.package];

    programs.bash.initExtra = mkIf cfg.enableBashIntegration (mkOrder 200 ''
      if [[ :$SHELLOPTS: =~ :(vi|emacs): ]]; then
        . ${cfg.package}/share/fzf/completion.bash
        . ${cfg.package}/share/fzf/key-bindings.bash
      fi
    '');

    programs.zsh.initExtra = mkIf cfg.enableZshIntegration (mkOrder 200 ''
      # HSTR configuration - add this to ~/.zshrc
      alias hh=hstr                    # hh to be alias for hstr
      setopt histignorespace           # skip cmds w/ leading space from history
      export HSTR_CONFIG=hicolor       # get more colors
      bindkey -s "\C-r" "\C-a hstr -- \C-j"     # bind hstr to Ctrl-r (for Vi mode check doc)
    '');

    programs.fish.shellInit = mkIf cfg.enableFishIntegration ''
      source ${cfg.package}/share/fzf/key-bindings.fish && fzf_key_bindings
    '';
  };
}
