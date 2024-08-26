{pkgs, ...}: {
  nixpkgs.overlays = let
    nix-matlab = import (builtins.fetchTarball "https://gitlab.com/doronbehar/nix-matlab/-/archive/master/nix-matlab-master.tar.gz");
  in [
    nix-matlab.overlay
    (
      final: prev: {
        # Your own overlays...
      }
    )
  ];

  # List packages installed in system profile. To search run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    home-manager

    # Cli
    alsa-lib # library for alsa
    alsa-utils # some audio utils like aplay
    appimage-run # run appimage
    autojump # cd command that learns
    bat # cat with colors
    bc # calculator -> for the watt script
    cmake # bild system generator
    cpufetch # fetch cpuinfo
    cryptsetup # luks
    ctags # fast source code browsing
    devmem2 # read from memory
    eza # fast ls
    fastfetch # neofetch with more infos
    fd # better find
    feh # image viewer
    ffmpeg # trascoder
    file # file infos
    firestarter # stress test for s-tui
    flac # music encoder
    fortune # random quote generator
    fzf # fuzzy search
    gccgo # C compiler
    git # really?
    gnumake # make command
    grc # colours
    grim # screenshots
    jq # JSON processor
    linuxKernel.packages.linux_6_6.turbostat # cpu stats
    lolcat # rainbow
    man-pages # man
    man-pages-posix # man 2
    msr-tools # edit cpu parameters
    neofetch # system info
    nix-output-monitor # output monitor nix
    num-utils # random
    openvpn # vpn client
    pamixer # set volume
    pciutils # pci ultis
    pulseaudio # for pactl
    qt5.qtwayland
    rclone # for nexcloud sync
    ripgrep # rust written grep
    s-tui # cpu monitoring and stress test
    speedtest-cli # internet speed-test
    stdenv # C compilers
    stress-ng # stress test
    texlive.combined.scheme-full # latex
    thefuck # yeah
    trash-cli # trash for terminal
    tree # ls files in folders
    usbutils # lsusb
    uwuify # UwU
    ventoy-full # multi boot USB
    wayvnc # vnc server for wayland
    wget # retrieve files using HTTP etc.
    wirelesstools # tools
    zfs # cool file system

    #  Archives
    p7zip
    unzip
    xarchiver # for file manager
    xz
    zip

    # Compatibility
    steam-run # all in one bin patcher

    # Tui
    bashmount # mount disks
    btop # task manager
    powertop # power usage info
    vim # backup text editor

    # Gui
    baobab # disk space manager
    btrfs-assistant # btrfs
    chromium # chromium
    evince # pdf
    firefox-wayland
    font-manager # useful for choosing glyphs
    gimp # editor
    kicad # electronic design
    libreoffice-qt # libre offive suite
    mpv # media player
    mpvpaper # live wall paper
    owncloud-client # gui client for owncloud
    pavucontrol # audio control
    pcmanfm # file manager
    sonixd # music player
    strawberry # music payer
    thunderbird # mail
    virt-manager # virtual machines
    zed-editor # IDE

    # Audio
    vmpk
    odin2
    qpwgraph

    # Non-free
    bambu-studio
    matlab
    spotify
    telegram-desktop

    # Python
    (python3.withPackages (ps:
      with ps; [
      ]))

    # Nodejs
    nodejs

    # Rust
    cargo
    rustc

    # Lua
    lua
    love

    #
    # nvim
    #
    glow # md previewer
    tree-sitter # for nvim

    # lsp
    clang # clang
    clang-tools # C, C++
    lua-language-server # lua
    marksman # markdown
    matlab-language-server # matlab
    nil # nix
    nodePackages_latest.bash-language-server # bash
    pyright # python
    rust-analyzer # rust
    shellcheck # checks shell scripts
    yaml-language-server # yaml

    # formatters
    alejandra # nix
    beautysh # sh
    black # python
    codespell # spell check
    glow # md previewer
    isort # python
    jq # json
    nodePackages_latest.prettier # prettier
    python311Packages.mdformat # python
    stylua # lua
    taplo # toml
    tree-sitter # for nvim

    # HTB
    aircrack-ng # wifi
    gobuster # file enumeration
    hydra-check # checks hydra modules
    john # hash
    netcat-openbsd # reverse shell
    hcxtools # convert hashes
    hashcat # de-passworder
    nmap # net enumeration
    samba # smbclient
    thc-hydra # ssh and other protocols

    # # Octave
    # (octave.withPackages
    #   (opkgs: with opkgs; [symbolic]))

    # Android
    android-tools
    newt
    pv
    srm

    # Drone
    betaflight-configurator
    edgetx

    # Gtk
    gnome-themes-extra
    gtk-engine-murrine
    kanagawa-gtk-theme

    # gitPkgs
    jep.fast-sl
    jep.modprobed-db
    # jep.ngspice
    jep.nofetch
    jep.setPL
    jep.jepmap
  ];

  # Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["FiraCode" "ComicShannsMono" "OpenDyslexic"];})
  ];

  # virtualisation.oci-containers = {
  #   backend = "docker";
  #   containers = {
  #     homer = {
  #       image = "b4bz/homer";
  #       #To build from source, comment previous line and uncomment below
  #       #build: .
  #       ports = [
  #         "127.0.0.1:45728:8080"
  #       ];
  #       volumes = [
  #         "/etc/services/homer:/www/assets"
  #       ];
  #       user = "1000:100"; # default
  #     };
  #   };
  # };
}
