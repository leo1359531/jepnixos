{
  config,
  pkgs,
  callPackage,
  ...
}: {
  environment.pathsToLink = ["/libexec"]; # links /libexec from derivations to /run/current-system/sw
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      vpl-gpu-rt # for newer GPUs on NixOS >24.05 or unstable
    ];
  };

  programs.firefox.enable = true;

  services = {
    xserver = {
      enable = true;

      desktopManager.xterm.enable = false;
      displayManager.startx.enable = true;

      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-rounded;
        extraPackages = with pkgs; [
          dunst # notification program
          i3lock-fancy #default i3 screen locker
          libnotify # notification lib
          picom # compositor
          polybar # bar
          polybar-pulseaudio-control # pipewire on the bar
          rofi # launcher
          xautolock # logout manager
        ];
      };
    };

    libinput = {
      enable = true;

      # disabling mouse acceleration
      mouse = {
        accelProfile = "flat";
        naturalScrolling = true;
      };
      # disabling touchpad acceleration
      touchpad = {
        accelProfile = "flat";
        naturalScrolling = true;
      };
    };
  };
}
