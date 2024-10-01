{
  pkgs,
  inputs,
  ...
}: {
  programs = {
    # hyprland = {
    #   enable = true;
    #   package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    #   portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    #
    #   # enableNvidiaPatches = true;
    # };

    gamemode = {
      enable = true;
    };

    ssh = {
      setXAuthLocation = true;
      forwardX11 = true;
    };

    # wireshark.enable = true;

    # sway = {
    #   enable = true;
    #   extraOptions = [
    #     "--verbose"
    #     "--debug"
    #     "--unsupported-gpu"
    #   ];
    # };
  };
}

