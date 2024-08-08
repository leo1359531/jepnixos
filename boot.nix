{
  config,
  pkgs,
  ...
}: {
  # bootloader
  boot = {
    initrd.kernelModules = [];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      systemd-boot.configurationLimit = 5; # Limits entry number
    };
    initrd.luks.devices.cryptroot.device = "/dev/disk/by-uuid/bc3364ae-b704-4066-923b-e5d27bba867a";

    # hibernation part
    resumeDevice = "/dev/disk/by-uuid/d84d217a-74e4-4705-991e-2f910b28b387";

    # silent boot
    kernelParams = [
      "resume_offset=17959152" # btrfs inspect-internal map-swapfile -r /swap/swapfile
      "quiet"
      "splash"
      "vga=current"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];

    supportedFilesystems = ["ntfs"];

    initrd.verbose = false;
    consoleLogLevel = 0;
  };

  powerManagement.enable = true;
  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
    fileSystems = ["/"];
  };

  # login manager
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd startx";
      };
    };
  };
}
