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
        # fah0 = {
        #   image = "foldingathome/fah-gpu-amd:latest";
        #   autoStart = true;
        #
        #   user = "1000:1000";
        #
        #   volumes = [
        #     "/home/denis/fah:/fah"
        #   ];
        #
        #   ports = [
        #     "127.0.0.1:7396:7396"
        #   ];
        #
        #   extraOptions = [
        #     "--device=/dev/kfd"
        #     "--device=/dev/dri"
        #     "--security-opt"
        #     "seccomp=unconfined"
        #     # "--group-add=video"
        #     # "--group-add=render"
        #   ];
        # };
      };
    };
  };

  systemd = {
    packages = with pkgs; [
      lact
    ];
    services.lactd.wantedBy = ["multi-user.target"];
  };

  services = {
    # foldingathome = {
    #   enable = true;
    #   user = "Dinesk";
    # };
    nix-serve = {
      enable = true;
      package = pkgs.nix-serve-ng;
      openFirewall = true;
      secretKeyFile = "/var/cache-priv-key.pem";
    };

    ratbagd = {
      enable = true;
    };

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

    dbus.enable = true;

    gvfs.enable = true;

    flatpak.enable = true;

    touchegg.enable = true;

    # cpupower-gui.enable = true;

    gnome.gnome-browser-connector.enable = true;

    zerotierone = {
      enable = true;
      joinNetworks = [
        "a84ac5c10a88bb46"
      ];
    };

    # asus-touchpad-numpad = {
    #   enable = true;
    #   model = "ux433fa";
    # };

    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;

    # displayManager = {
    #   enable = false;
    # };

    displayManager = {
      # autoLogin = {
      #   enable = true;
      #   user = "denis";
      # };

      # gdm.enable = true;
      sddm = {
        enable = true;
        wayland.enable = true;
        autoNumlock = true;
        # settings.General.DisplayServer = "wayland";
      };
      # lightdm.enable = true;
    };

    desktopManager = {
      # gnome.enable = true;
      # plasma5.enable = false;
      plasma6.enable = true;
    };
    xserver = {
      # Enable the X11 windowing system.
      enable = false;

      # Configure keymap in X11
      # xkbOptions = "grp:alt_shift_toggle";
      xkb = {
        layout = "us, ru";
        # options = "caps:none";
      };

      videoDrivers = ["amdgpu"];
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
      cacheEntriesMax = 0;
      openFirewall = true;
      nssmdns4 = true;
      ipv4 = true;
      ipv6 = false;
      allowInterfaces = ["enp13s0"];
      publish = {
        enable = true;
        domain = true;
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

