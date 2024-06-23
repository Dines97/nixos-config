{
  config,
  pkgs,
  ...
}: {
  programs.nixvim.colorschemes = {
    onedark = {
      enable = true;
      settings = {
        style = "darker";
        code_style = {
          comments = "none";
          keywords = "italic";
        };
      };
    };
  };
}
