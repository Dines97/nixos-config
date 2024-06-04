{...}: {
  # Remove sound.enable or turn it off if you had it set previously, it seems to cause conflicts with pipewire
  sound.enable = false;

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
