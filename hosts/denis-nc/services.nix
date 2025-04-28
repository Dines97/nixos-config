{pkgs, ...}: {
  virtualisation = {
    oci-containers = {
      containers = {
        flaresolverr = {
          image = "ghcr.io/flaresolverr/flaresolverr:latest";
          ports = [
            "8191:8191"
          ];
          environment = {
            LOG_LEVEL = "info";
          };
        };
      };
    };
  };

  services = {
    # mozillavpn = {
    #   enable = true;
    # };

    dnscrypt-proxy2 = {
      enable = true;
      settings = {
        ipv6_servers = true;
        require_dnssec = true;

        sources.public-resolvers = {
          urls = [
            "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
            "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
          ];
          cache_file = "/var/lib/dnscrypt-proxy/public-resolvers.md";
          minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        };
      };
    };

    cloudflare-warp.enable = false;

    fwupd.enable = true;

    # 9696
    prowlarr = {
      enable = true;
    };

    # 8686
    lidarr = {
      enable = false;
    };

    headphones = {
      enable = false;
    };

    # show
    # 8989
    # sonarr = {
    #   enable = true;
    # };

    # 8191
    # flaresolverr = {
    #   enable = true;
    # };

    rke2 = {
      enable = false;
      nodeIP = "192.168.1.105";
      extraFlags = [
        "--disable-cloud-controller"
      ];
      disable = [
        "rke2-ingress-nginx"
        "rke2-snapshot-controller"
        "rke2-snapshot-controller-crd"
        "rke2-snapshot-validation-webhook"
      ];
    };

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

    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;

    # displayManager = {
    #   enable = false;
    # };

    xserver = {
      # Enable the X11 windowing system.
      enable = true;

      # Configure keymap in X11
      # xkbOptions = "grp:alt_shift_toggle";
      xkb = {
        layout = "us, ru";
        # options = "caps:none";
      };

      # videoDrivers = ["nvidia"];

      displayManager = {
        # autoLogin = {
        #   enable = true;
        #   user = "denis";
        # };

        # gdm.enable = true;
        sddm.enable = true;
        # lightdm.enable = true;
      };

      desktopManager = {
        # gnome.enable = true;
        # plasma5.enable = false;
        plasma6.enable = true;
      };
    };

    samba = {
      enable = true;
      openFirewall = true;
      # securityType = "user";
      settings = {
        global = {
          "hosts allow" = "192.168. 10.147.19. 127.0.0.1 localhost";
          "hosts deny" = "0.0.0.0/0";
        };
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
      allowInterfaces = ["enp0s20f0u1"];
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

