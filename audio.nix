{
  # Audio
  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    extraConfig.pipewire = {
      "default.clock.rate" = 96000;
      "default.clock.allowed-rates" = [48000 96000];
      "default.clock.min-quantum" = 32;
      "default.clock.max-quantum" = 8192;
      "default.clock.quantum" = 1024;
      "default.clock.quantum-limit" = 8192;
      "default.clock.quantum-floor" = 32;
    };
  };
  # hardware.pulseaudio.zeroconf.discovery.enable = true;
}
