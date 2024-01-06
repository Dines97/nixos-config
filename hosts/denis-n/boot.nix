{...}: {
  boot = {
    initrd = {
      availableKernelModules = ["xhci_pci" "nvme" "rtsx_usb_sdmmc"];
      kernelModules = [];
    };
    kernelModules = ["kvm-intel" "iwlwifi" "usbhid" "joydev" "xpad"];
    extraModulePackages = [];

    blacklistedKernelModules = [
      "uvcvideo"
    ];

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

    # kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
    # kernelPackages = pkgs.linuxKernel.packages.linux_testing;

    # plymouth = {
    #   enable = true;
    #   theme = "breeze";
    # };
    # initrd.systemd.enable = true;
  };
}
