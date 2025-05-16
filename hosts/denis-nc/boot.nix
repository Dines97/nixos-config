{pkgs, ...}: {
  boot = {
    kernel = {
      sysctl = {
        "kernel.sysrq" = 1;
        "vm.max_map_count" = 2147483642;
      };
    };

    # kernelParams = ["amd_pstate=active"];

    initrd = {
      availableKernelModules = ["nvme" "xhci_pci" "ahci" "thunderbolt" "usbhid" "usb_storage" "sd_mod"];
      # kernelModules = ["amdgpu"];

      # systemd.enable = true;

      network = {
        ssh = {
          enable = true;
          port = 22;
          authorizedKeys = [
            "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCqJaPV/2jidFU9D9Xiz8NFt2dligI/yGLHJzbGuJuaLbfGQgbwIrKRn5JhT5zvPWtiRW2IXq/f3a/ZDvmunFGFTotr5bL9PgCTJxjJhXf/g7EDVEKV5qZBTmON3yRezlWDTbR2tJwuxt6rowcOqLNW/lljs53Iui0UpHjdyU1Plh390T4IdFl8BDzwiQPGDtJAbukjQWrCrTHEkql5stD9m5AOyANgxBzt6VEtGhFHh+o2iCChOBWvtjdvqRMIPk1PhEhpzdu55NLZ9l8KTT+sm10T+6h5/zdEviLITHbYRdzvTRrz2//SRRaKxweKMLXXsO9HHFwreLjviZTkU1ZYxAah8dxgH5/q4syUYQ8V77NVLMQ253/v09Itlp0lsXyld7bfVZ12yQtMMvRaIh0emg3JupPHoIySS0ye49Uynat3jtkYT1fJpr3/uZdzKBHrrJdw+/ZnziF/wE6VLlTkcGbk9tWOSuXagD35EVpzspk37C+Me5gOQq2p4IOawwM= root@Denis-N "
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC/G+pCzalAw0XAwdE/M+8az+OkN3+MC6XCxrzY3wtYq root@Denis-N"
          ];
          hostKeys = [
            "/etc/secrets/initrd/ssh_host_rsa_key"
            "/etc/secrets/initrd/ssh_host_ed25519_key"
          ];
        };
      };
    };

    tmp = {
      cleanOnBoot = true;
    };

    loader = {
      # Use the systemd-boot EFI boot loader.
      systemd-boot = {
        enable = true;
        memtest86.enable = true;
      };
      efi.canTouchEfiVariables = true;
    };

    supportedFilesystems = ["ntfs" "exfat"];

    kernelPackages = pkgs.linuxPackages_cachyos;
    # kernelPackages = pkgs.linuxKernel.packages.linux_xanmod;
    # kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    # kernelPackages = pkgs.linuxPackages_latest;

    # plymouth = {
    #   enable = true;
    #   theme = "breeze";
    # };
  };
}

