{...}: {
  specialisation = {
    plasma.configuration = {
      programs = {
        # regreet = {
        #   enable = true;
        # };
      };

      services = {
        # greetd = {
        #   enable = true;
        # };

        xserver = {
          enable = false;

          displayManager = {
            # gdm.enable = true;

            # sddm = {
            #   enable = true;
            #   settings = {
            #     General = {
            #       DisplayServer = "wayland";
            #     };
            #   };
            # };
          };

          desktopManager = {
            plasma5.enable = true;
          };

          # windowManager = {
          #   i3 = {
          #     enable = true;
          #     package = pkgs.i3-gaps;
          #   };
          #
          #   xmonad = {
          #     enable = true;
          #     enableContribAndExtras = true;
          #     extraPackages = haskellPackages: [
          #       # haskellPackages.xmonad-wallpaper
          #     ];
          #   };
          #
          #   awesome.enable = true;
          # };
        };
      };
    };
  };
}
