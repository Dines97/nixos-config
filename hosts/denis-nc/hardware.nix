{
  pkgs,
  lib,
  config,
  ...
}: {
  hardware = {
    # amdgpu = {
    #   amdvlk = {
    #     enable = true;
    #     support32Bit = {
    #       enable = true;
    #     };
    #   };
    # };
    # xpadneo.enable = true;
    enableAllFirmware = true;
    enableRedistributableFirmware = true;

    graphics = {
      enable = true;
      enable32Bit = true;

      extraPackages = with pkgs; [
        amdvlk
        clinfo
        libcxx
        rocmPackages.clr.icd
        rocmPackages.hipblas
        rocmPackages.rocblas
        rocmPackages.rocm-runtime
        rocmPackages.rocminfo
        stdenv.cc.cc
        # intel-media-driver # LIBVA_DRIVER_NAME=iHD
        # libva
        # intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
        # vaapiVdpau
        # libvdpau-va-gl
        # # libGL
        # mesa
      ];
      extraPackages32 = with pkgs.driversi686Linux; [
        amdvlk
      ];
      # setLdLibraryPath = true;
    };

    cpu.amd.updateMicrocode = true;
  };
}

