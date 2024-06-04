{pkgs, ...}: {
  services = {
    # pcscd.enable = true;
    # dbus.packages = [pkgs.gcr pkgs.gcr_4];

    gvfs.enable = true;

    flatpak.enable = true;

    touchegg.enable = true;

    cpupower-gui.enable = true;

    gnome.gnome-browser-connector.enable = true;

    zerotierone = {
      enable = true;
      joinNetworks = [
        "a84ac5c10a88bb46"
      ];
    };

    asus-touchpad-numpad = {
      enable = true;
      model = "ux433fa";
    };

    xserver = {
      # Enable the X11 windowing system.
      enable = true;

      # Configure keymap in X11
      # xkbOptions = "grp:alt_shift_toggle";
      xkb = {
        layout = "us, ru";
        # options = "caps:none";
      };

      videoDrivers = ["nvidia"];

      # Enable touchpad support (enabled default in most desktopManager).
      libinput.enable = true;

      displayManager = {
        # autoLogin = {
        #   enable = true;
        #   user = "denis";
        # };

        gdm.enable = true;
        # sddm.enable = true;
        # lightdm.enable = true;
      };

      desktopManager = {
        gnome.enable = true;
        # plasma5.enable = false;
        # plasma6.enable = true;
      };
    };

    samba = {
      enable = false;
      openFirewall = false;
      # securityType = "user";
      extraConfig = ''
        workgroup = WORKGROUP
        server string = smbnix
        netbios name = smbnix
        hosts allow = 192.168. 10.147.19. 127.0.0.1 localhost
        hosts deny = 0.0.0.0/0
      '';
      shares = {
        public = {
          path = "/home/denis/shared";
          browseable = "yes";
          "guest ok" = "yes";
          "read only" = "no";
          "create mask" = "0755";
        };
      };
    };

    # resolved = {
    #   enable = true;
    #   llmnr = "true";
    #   dnssec = "true";
    #
    #   extraConfig = ''
    #     [Resolve]
    #     MulticastDNS=true
    #   '';
    # };

    samba-wsdd = {
      enable = true;
      discovery = true;
    };

    avahi = {
      enable = true;
      openFirewall = true;
      nssmdns4 = true;
      ipv4 = true;
      ipv6 = false;
      # allowInterfaces = ["enp0s20f0u1u2"];
      publish = {
        enable = true;
        addresses = true;
      };
      # domainName = "alocal";
      # browseDomains = ["alocal"];
    };

    # Enable CUPS to print documents.
    printing.enable = true;

    # Enable the OpenSSH daemon.
    openssh = {
      enable = true;
      openFirewall = true;
      settings = {
        PermitRootLogin = "yes";
      };
    };

    # barrier.client = {
    #   enable = true;
    #   enableCrypto = true;
    #   enableDragDrop = false;
    #   name = "Denis-N";
    #   server = "Denis-PC";
    # };

    glances = {
      enable = false;
    };
    preload = {
      enable = true;
    };
  };
}
