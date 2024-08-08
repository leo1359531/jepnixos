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
          i3lock #default i3 screen locker
          i3status # gives you the default i3 status bar
          picom
          polybar
          polybar-pulseaudio-control
          rofi
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
