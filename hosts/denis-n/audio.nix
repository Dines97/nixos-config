{...}: {
  hardware.pulseaudio = {
    enable = false;
    # extraConfig = "unload-module module-combine-sink";
  };

  services.pipewire = {
    enable = true;
    audio.enable = true;

    alsa = {
      enable = true;
      support32Bit = false;
    };
    pulse.enable = true;
    jack.enable = true;

    wireplumber = {
      enable = true;
    };
  };
}
