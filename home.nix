{
  config,
  pkgs,
  ...
}: let
  # home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz";
in {
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.leo = {
    /*
    The home.stateVersion option does not have a default and must be set
    */
    home.stateVersion = "24.05";

    programs.bash = {
      enable = true;
      enableCompletion = true;
      historyControl = [
        "erasedups"
        "ignorespace"
      ];
      historySize = 10000;
      historyIgnore = [
        "l"
        "cd"
        "v"
      ];

      # complete -cf doas enables autocomplete with doas
      initExtra = ''
        complete -cf doas
        bind -s 'set completion-ignore-case on'
        nofetch -UwU
      '';

      shellAliases = {
        add = "ssh-add ~/.ssh/starless";
        c = "clear && fast-sl && clear";
        duu = "du --max-depth=1 -h";
        edit = "cd /etc/nixos";
        ilmatar = "ssh -p 59743 vainamoinen@dreams.scatcat.online";
        thor = "ssh -p 42938 benedetta@thor";
        j = "autojump";
        l = "exa -ahl";
        ll = "ls -l";
        lsblk = "lsblk -o NAME,FSTYPE,SIZE,FSUSED,LABEL,MOUNTPOINT,RM,RO,UUID";
        rm = "trash";
        update = "sudo nixos-rebuild switch";
        v = "nvim";
      };
    };

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      history.ignoreAllDups = true;
      history.ignoreSpace = true;
      history.share = true;
      syntaxHighlighting.enable = true;
      # complete -cf doas enables autocomplete with doas
      initExtra = ''
        if [ "$TMUX" = "" ]; then tmux; fi
        nofetch -UwU
      '';
      shellAliases = {
        add = "ssh-add ~/.ssh/starless";
        c = "clear && fast-sl && clear";
        duu = "du --max-depth=1 -h";
        edit = "cd /etc/nixos";
        ilmatar = "ssh -p 59743 vainamoinen@dreams.scatcat.online";
        thor = "ssh -p 42938 benedetta@thor";
        j = "autojump";
        l = "exa -ahl";
        ll = "ls -l";
        lsblk = "lsblk -o NAME,FSTYPE,SIZE,FSUSED,LABEL,MOUNTPOINT,RM,RO,UUID";
        rr = "trash";
        update = "sudo nixos-rebuild switch";
        v = "nvim";
      };
    };

    programs.firefox = {
      enable = true;
      profiles = {
        default = {
          id = 0;
          name = "default";
          isDefault = true;
          settings = {
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            "layers.acceleration.force-enabled" = true;
            "gfx.webrender.all" = true;
            "gfx.webrender.enabled" = true;
            "layout.css.backdrop-filter.enabled" = true;
            "svg.context-properties.content.enabled" = true;

            # LINUX ONLY - WORKAROUND FOR BAR HIDING ON DRAG EVENT
            "widget.gtk.ignore-bogus-leave-notify" = 1;

            # Firefox 75+ remembers the last workspace it was opened on as part of its session management.
            # This is annoying, because I can have a blank workspace, click Firefox from the launcher, and
            # then have Firefox open on some other workspace.
            "widget.disable-workspace-management" = true;
          };
          userChrome = ''
            #sidebar-header {
              display: none;
            }
            #sidebar-header {
            /* display: none; */
              visibility: collapse !important;
            }
            #sidebar-box[sidebarcommand="_3c078156-979c-498b-8990-85f7987dd929_-sidebar-action"] + #sidebar-splitter {
              display: none !important;
            }
            :root {
              --thin-tab-width: 32px;
              --wide-tab-width: 300px;
            }
            #sidebar-box:not([sidebarcommand="_3c078156-979c-498b-8990-85f7987dd929_-sidebar-action"]) {
              min-width: var(--wide-tab-width) !important;
              max-width: none !important;
            }
            #sidebar-box[sidebarcommand="_3c078156-979c-498b-8990-85f7987dd929_-sidebar-action"] {
              overflow: hidden !important;
              position: relative !important;
              transition: all 300ms !important;
              /*transition: all 0ms 0s !important;*/
              min-width: var(--thin-tab-width) !important;
              max-width: var(--thin-tab-width) !important;
              z-index: 2;
            }
            #sidebar-box[sidebarcommand="_3c078156-979c-498b-8990-85f7987dd929_-sidebar-action"]:hover,
            #sidebar-box[sidebarcommand="_3c078156-979c-498b-8990-85f7987dd929_-sidebar-action"] #sidebar {
              /*transition-delay: 0s !important;*/
              transition: all 300ms !important;
              min-width: var(--wide-tab-width) !important;
              max-width: var(--wide-tab-width) !important;
              z-index: 1;
            }
            #sidebar-box[sidebarcommand="_3c078156-979c-498b-8990-85f7987dd929_-sidebar-action"]:hover {
              margin-right: calc((var(--wide-tab-width) - var(--thin-tab-width)) * -1) !important;
            }
            #main-window #titlebar {
              overflow: hidden;
              transition: height 0.3s 0.3s !important;
            }
            /* Default state: Set initial height to enable animation */
            /* #main-window #titlebar { height: 3em !important; } */
            #main-window[uidensity="touch"] #titlebar { height: 3.35em !important; }
            #main-window[uidensity="compact"] #titlebar { height: 2.7em !important; }
            /* Hidden state: Hide native tabs strip */
            #main-window[titlepreface*="‎"] #titlebar { height: 0 !important; }
            /* Hidden state: Fix z-index of active pinned tabs */
            #main-window[titlepreface*="‎"] #tabbrowser-tabs { z-index: 0 !important; }

          '';
          search = {
            force = true;
            default = "Google";
          };
        };
      };
    };
    gtk = {
      enable = true;
      theme = {
        package = pkgs.kanagawa-gtk-theme;
        name = "Kanagawa-B";
      };
    };

    programs.git = {
      enable = true;
      userName = "leo359531";
      userEmail = "leos1359531@gmail.com";
    };

    imports = [
      ./dotfiles/dotfiles.nix
    ];
  };
}
