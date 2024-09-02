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
      plugins = [
        {
          name = "vi-mode";
          src = pkgs.zsh-vi-mode;
          file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        }
      ];
      enableCompletion = true;
      history.ignoreAllDups = true;
      history.ignoreSpace = true;
      history.share = true;
      syntaxHighlighting.enable = true;
      # complete -cf doas enables autocomplete with doas
      initExtra = ''
        if [ "$TMUX" = "" ]; then tmux; fi
        # nofetch -UwU
      '';
      shellAliases = {
        add = "ssh-add ~/.ssh/starless";
        c = "clear && fast-sl && clear";
        duu = "du --max-depth=1 -h";
        edit = "cd /etc/nixos";
        ilmatar = "ssh -p 59743 vainamoinen@dreams.scatcat.online";
        j = "autojump";
        l = "exa -ahl";
        ll = "ls -l";
        lsblk = "lsblk -o NAME,FSTYPE,SIZE,FSUSED,LABEL,MOUNTPOINT,RM,RO,UUID";
        rr = "trash";
        thor = "ssh -p 42938 benedetta@thor";
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

            # disable translation popup panel
            "browser.translations.automaticallyPopup" = false;
          };
          userChrome = ''
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
