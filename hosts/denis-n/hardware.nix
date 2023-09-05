{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  hardware = {
    nvidia = {
      open = false;

      modesetting.enable = true;
      # package = config.boot.kernelPackages.nvidiaPackages.beta;

      forceFullCompositionPipeline = true;

      prime = {
        # offload.enable = true;
        sync.enable = true;

        # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
        intelBusId = "PCI:0:2:0";

        # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
        nvidiaBusId = "PCI:2:0:0";
      };
    };

    opengl = {
      enable = true;
      # driSupport32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver # LIBVA_DRIVER_NAME=iHD
        libva
        vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
        vaapiVdpau
        libvdpau-va-gl
        # libGL
        mesa.drivers
      ];
    };

    pulseaudio = {
      enable = false;
      extraConfig = "unload-module module-combine-sink";
    };
  };
}