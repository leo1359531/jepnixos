{
  config,
  pkgs,
  callPackage,
  ...
}: let
  lock-false = {
    Value = false;
    Status = "locked";
  };
  lock-true = {
    Value = true;
    Status = "locked";
  };
  lock-empty-string = {
    Value = "";
    Status = "locked";
  };
in {
  programs.firefox = {
    enable = true;

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DontCheckDefaultBrowser = true;
      DisablePocket = true;
      SearchBar = "unified";

      Preferences = {
        # Privacy settings
        "extensions.pocket.enabled" = lock-false;
        "browser.newtabpage.pinned" = lock-empty-string;
        "browser.topsites.contile.enabled" = lock-false;
        "browser.newtabpage.activity-stream.showSponsored" = lock-false;
        "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
      };

      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          installation_mode = "force_installed";
        };
        "{3c078156-979c-498b-8990-85f7987dd929}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/sidebery/latest.xpi";
          installation_mode = "force_installed";
        };
        "newtaboverride@agenedia.com" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/new-tab-override/latest.xpi";
          installation_mode = "force_installed";
        };
        "{9b84b6b4-07c4-4b4b-ba21-394d86f6e9ee}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/black21/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };
  };

  environment.pathsToLink = ["/libexec"]; # links /libexec from derivations to /run/current-system/sw
  # hardware.graphics = {
  #   enable = true;
  #   extraPackages = with pkgs; [
  #     # vpl-gpu-rt # for newer GPUs on NixOS >24.05 or unstable
  #   ];
  # };
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      # vpl-gpu-rt # for newer GPUs on NixOS >24.05 or unstable
      onevpl-intel-gpu # for newer GPUs on NixOS <= 24.05
      # intel-media-sdk   # for older GPUs
    ];
  };

  services = {
    xserver = {
      enable = true;

      desktopManager.xterm.enable = false;
      displayManager.startx.enable = true;

      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-rounded;
        extraPackages = with pkgs; [
          alacritty # backup terminal
          dunst # notification program
          i3lock-color #default i3 screen locker
          libnotify # notification lib
          picom # compositor
          polybarFull # bar
          polybar-pulseaudio-control # pipewire on the bar
          rofi # launcher
          xss-lock # lock
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
