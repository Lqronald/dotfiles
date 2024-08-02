{
  pkgs,
  ...
}:

{
   environment.systemPackages = with pkgs; [
    appimage-run
    btop
    cpufetch
    cmatrix
    eza
    #fastfetch
    fzf
    git
    gnome-disk-utility
    inxi
    kdePackages.kcalc
    kdePackages.kcmutils
    killall
    libreoffice
    #libsForQt5.qt5ct
    #libsForQt5.qtstyleplugin-kvantum
    libvirt
    meld
    micro
    mpv
    neofetch
    okular
    protonup-qt
    protontricks
    qbittorrent
    ripgrep
    #rustdesk
    spotify
    #virt-viewer
    v4l-utils
    wget
    winetricks
    kdePackages.yakuake
  ];

  programs = {
    #firefox.enable = true;
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

    virt-manager.enable = false;

    steam = {
      enable = true;
      #gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

  };

}
