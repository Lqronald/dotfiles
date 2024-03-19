{ pkgs, config, inputs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List System Programs
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
    eza
    git
    gnome.gnome-disk-utility
    helix
    htop
    killall
    libnotify
    libreoffice
    libvirt
    lm_sensors
    lolcat
    lsd
    lshw
    material-icons
    meld
    micro
    neofetch
    networkmanagerapplet
    noto-fonts-color-emoji
    okular
    playerctl
    polkit_gnome
    ripgrep
    swappy
    #symbola
    toybox
    unrar
    unzip
    virt-viewer
    #v4l-utils
    wget
    wineWowPackages.stable
    wineWowPackages.staging
    winetricks
    wl-clipboard
    ydotool
  ];

  programs.steam.gamescopeSession.enable = true;

  programs.dconf.enable = true;

  #services.xserver.desktopManager.plasma6.enable = true;

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    xwayland.enable = true;
  };
  
  programs.fuse.userAllowOther = true;
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
}
