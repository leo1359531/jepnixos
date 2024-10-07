{pkgs, ...}: let
  unstable = import <nixos-unstable> {config = {allowUnfree = true;};};
in {
  # List packages installed in system profile. To search run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    home-manager

    unstable.zed-editor
    unstable.neovim

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
    openjdk # java
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
    trash-cli # trash for terminal
    tree # ls files in folders
    usbutils # lsusb
    uwuify # UwU
    ventoy-full # multi boot USB
    wayvnc # vnc server for wayland
    wget # retrieve files using HTTP etc.
    wirelesstools # tools

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
    owncloud-client # owncloud
    pavucontrol # audio control
    pcmanfm # file manager
    sonixd # music player
    strawberry # music payer
    thunderbird # mail
    virt-manager # virtual machines

    # Audio
    vmpk
    odin2
    qpwgraph

    # Zsh
    zsh-autocomplete
    zsh-autoenv
    zsh-autopair
    zsh-autosuggestions
    zsh-syntax-highlighting

    # Non-free
    bambu-studio
    discord
    modrinth-app
    spotify
    telegram-desktop

    # Python
    (python3.withPackages (ps:
      with ps; [
      ]))

    # Rust
    cargo
    rustc

    # Lua
    lua
    love

    #
    # nvim
    #
    unstable.nodejs
    unstable.glow # md previewer
    unstable.tree-sitter # for nvim

    # lsp
    unstable.clang # clang
    unstable.clang-tools # C, C++
    unstable.lua-language-server # lua
    unstable.marksman # markdown
    unstable.nil # nix
    unstable.nodePackages_latest.bash-language-server # bash
    unstable.pyright # python
    unstable.rust-analyzer # rust
    unstable.shellcheck # checks shell scripts
    unstable.yaml-language-server # yaml

    # formatters
    unstable.alejandra # nix
    unstable.beautysh # sh
    unstable.black # python
    unstable.codespell # spell check
    unstable.glow # md previewer
    unstable.isort # python
    unstable.jq # json
    unstable.nodePackages_latest.prettier # prettier
    unstable.python311Packages.mdformat # python
    unstable.stylua # lua
    unstable.taplo # toml

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
    # jep.ngspice
    jep.fast-sl
    # jep.forge-mtg
    # jep.eigen
    jep.lis
    jep.jepmap
    jep.modprobed-db
    jep.nofetch
    jep.setPL
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
