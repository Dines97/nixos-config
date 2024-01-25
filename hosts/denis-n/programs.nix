{pkgs, ...}: {
  programs = {
    # hyprland = {
    #   enable = true;
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
