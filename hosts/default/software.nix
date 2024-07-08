{
  pkgs,
  username,
  ...
}:

  #nixpkgs.config.allowUnfree = true;

{
   environment.systemPackages = with pkgs; [
    appimage-run
    brightnessctl
    btop
    cava
    cpufetch
    cmatrix
    curl
    cowsay
    dolphin
    duf
    eza
    fastfetch
    git
    gnome.gnome-disk-utility
    gnome.file-roller
    grim
    htop
    inxi
    kate
    killall
    libnotify
    libreoffice
    libsForQt5.ark
    libsForQt5.kate
    libvirt
    lm_sensors
    lolcat
    lsd
    lshw
    lxqt.lxqt-policykit
    material-icons
    meld
    micro
    neofetch
    networkmanagerapplet
    noto-fonts-color-emoji
    okular
    playerctl
    polkit_gnome
    phinger-cursors
    protonup-qt
    protontricks
    qimgv
    qbittorrent
    ripgrep
    rustdesk
    swappy
    toybox
    unrar
    unzip
    virt-viewer
    v4l-utils
    wget
    wineWowPackages.stable
    wineWowPackages.staging
    winetricks
    wireplumber
    wl-clipboard
    ydotool
  ];


  programs = {
    firefox.enable = true;
    starship = {
      enable = true;
      settings = {
        add_newline = false;
        buf = {
          symbol = " ";
        };
        c = {
          symbol = " ";
        };
        directory = {
          read_only = " 󰌾";
        };
        docker_context = {
          symbol = " ";
        };
        fossil_branch = {
          symbol = " ";
        };
        git_branch = {
          symbol = " ";
        };
        golang = {
          symbol = " ";
        };
        hg_branch = {
          symbol = " ";
        };
        hostname = {
          ssh_symbol = " ";
        };
        lua = {
          symbol = " ";
        };
        memory_usage = {
          symbol = "󰍛 ";
        };
        meson = {
          symbol = "󰔷 ";
        };
        nim = {
          symbol = "󰆥 ";
        };
        nix_shell = {
          symbol = " ";
        };
        nodejs = {
          symbol = " ";
        };
        ocaml = {
          symbol = " ";
        };
        package = {
          symbol = "󰏗 ";
        };
        python = {
          symbol = " ";
        };
        rust = {
          symbol = " ";
        };
        swift = {
          symbol = " ";
        };
        zig = {
          symbol = " ";
        };
      };
    };
    dconf.enable = true;
    fuse.userAllowOther = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    virt-manager.enable = true;

    steam = {
      enable = true;
      #gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    thunar = {
      enable = false;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
  };

}
