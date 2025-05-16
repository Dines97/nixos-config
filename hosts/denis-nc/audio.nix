{...}: {
  services = {
    pulseaudio = {
      enable = false;
      # extraConfig = "unload-module module-combine-sink";
    };

    pipewire = {
      enable = true;
      audio.enable = true;

      alsa = {
        enable = true;
        # Required for steam
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;

      wireplumber = {
        enable = true;
      };
    };
  };
}

