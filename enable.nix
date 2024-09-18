{pkgs, ...}: {
  # Virt-Manager
  virtualisation.docker.enable = false;
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  # SSH angent
  programs.ssh.startAgent = true;

  # Neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [];
      theme = "robbyrussell";
    };
  };

  environment.pathsToLink = ["/share/zsh"]; # for zsh autocompletion

  programs.tmux = {
    enable = true;
    plugins = with pkgs; [
      tmuxPlugins.battery
      tmuxPlugins.prefix-highlight
      tmuxPlugins.online-status
      tmuxPlugins.sidebar
      tmuxPlugins.copycat
      tmuxPlugins.open
      tmuxPlugins.sysstat
    ];
  };

  # File manager
  programs.thunar.enable = true;
  programs.xfconf.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  # Enable
  programs = {
    light.enable = true; # brightness control
    waybar.enable = true; # bar
  };

  services = {
    resolved = {
      enable = true;
      # fallbackDns = [
      # "208.67.222.222"
      # "2620:119:35::35"
      # ];
    };

    kanata = {
      enable = true;
      keyboards = {
        internalKeyboard = {
          extraDefCfg = "process-unmapped-keys yes";
          config = ''
            (defsrc
             caps
            )
            (defvar
             tap-time 150
             hold-time 200
            )

            (defalias
             caps (tap-hold 100 100 esc lctl)
            )

            (deflayer base
             @caps
            )
          '';
        };
      };
    };

    # Fprint - fingerprint
    fprintd = {
      enable = false;
      tod = {
        enable = false;
        driver = pkgs.libfprint-2-tod1-goodix-550a;
      };
    };

    # Power Management

    # Tlp
    tlp = {
      enable = true;
      settings = {
        TLP_ENABLE = 1;

        START_CHARGE_THRESH_BAT0 = 75;
        STOP_CHARGE_THRESH_BAT0 = 80;
        RUNTIME_PM_ON_BAT = "auto";

        TLP_DEFAULT_MODE = "BAT";

        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

        PLATFORM_PROFILE_ON_AC = "performance";
        PLATFORM_PROFILE_ON_BAT = "low-power";

        CPU_MIN_PERF_ON_AC = "100";
        CPU_MAX_PERF_ON_AC = "100";
        CPU_MIN_PERF_ON_BAT = "0";
        CPU_MAX_PERF_ON_BAT = "100";

        CPU_BOOST_ON_AC = "1";
        CPU_BOOST_ON_BAT = "1";
      };
    };

    # Tailscale
    tailscale.enable = true;
  };

  # Android
  programs.adb.enable = true;
  users.users.leo.extraGroups = ["adbusers"];

  services.udev.packages = [
    (pkgs.writeTextFile {
      name = "numworks";
      text = ''
        SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="a291", TAG+="uaccess"
        SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="df11", TAG+="uaccess"
      '';

      destination = "/etc/udev/rules.d/50-numwork-calculator.rules";
    })
  ];
}
