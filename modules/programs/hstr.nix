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
    enable = mkEnableOption "bash and zsh shell history suggest box - easily view, navigate, search and manage your command history";

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
  };

  config = mkIf cfg.enable {
    home.packages = [cfg.package];

    programs.bash.initExtra = mkIf cfg.enableBashIntegration ''
      eval "$(${pkgs.hstr}/bin/hstr --show-configuration)"
    '';

    programs.zsh.initExtra = mkIf cfg.enableZshIntegration ''
      eval "$(${pkgs.hstr}/bin/hstr --show-zsh-configuration)"
    '';
  };
}
