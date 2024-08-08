{
  # Enable networking
  networking = {
    hostName = "starless";
    wireless.iwd.enable = true;
    # networkmanager.enable = true;
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [18000];
  };

  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  hardware.bluetooth.settings = {
    General = {
      Enable = "Source,Sink,Media,Socket";
    };
  };
}
