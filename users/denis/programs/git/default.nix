{
  pkgs,
  config,
  lib,
  ...
}: {
  home = {
    packages = with pkgs; [
      git-credential-manager
    ];
  };

  programs = {
    git = {
      enable = true;
      userName = "Denis Kaynar";
      userEmail = "kaynar.denis@gmail.com";
      extraConfig = {
        credential = {
          helper = "${pkgs.git-credential-manager}/bin/git-credential-manager";
          credentialStore = "plaintext";
          useHttpPath = true;
        };

        init.defaultBranch = "master";
        core.autocrlf = "input";
      };
      lfs.enable = true;
      ignores = lib.splitString "\n" (builtins.readFile (builtins.fetchurl {
        url = "https://www.toptal.com/developers/gitignore/api/linux,windows,macos,jetbrains,jetbrains+all,jetbrains+iml,vim,visualstudio,visualstudiocode,rider,intellij,intellij+all,intellij+iml,pycharm,pycharm+all,pycharm+iml,direnv";
        name = "gitignore";
        sha256 = "sha256:1iy56spzvdmmd1f1b6i25s0y6jjvb0cj61i2lz06xq6164ingbsx";
      }));
    };
  };
}
