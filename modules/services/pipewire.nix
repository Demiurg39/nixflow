{...}: {
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # make pipewire realtime-capable
  security.rtkit.enable = true;
}
