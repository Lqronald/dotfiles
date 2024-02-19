{ pkgs, config, username, ... }:

let 
  inherit (import ../../options.nix) 
    browser wallpaperDir wallpaperGit flakeDir;
in {
  # Install Packages For The User
  home.packages = with pkgs; [
    pkgs."${browser}"
    discord
    font-awesome
    gimp
    gnome.file-roller
    grim
    libsForQt5.kate
    libsForQt5.qt5ct
    libsForQt5.qt5.qtquickcontrols
    libsForQt5.qt5.qtgraphicaleffects
    librewolf
    libvirt
    mpv
    neovide
    pavucontrol
    pyprland
    qimgv
    qbittorrent
    rofi-wayland
    slurp
    spotify
    swayidle
    swaylock
    swaynotificationcenter
    swww
    vlc

    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    # Import Scripts
    (import ./../scripts/emopicker9000.nix { inherit pkgs; })
    (import ./../scripts/task-waybar.nix { inherit pkgs; })
    (import ./../scripts/squirtle.nix { inherit pkgs; })
    (import ./../scripts/wallsetter.nix { inherit pkgs; inherit wallpaperDir;
      inherit username; inherit wallpaperGit; })
    (import ./../scripts/themechange.nix { inherit pkgs; inherit flakeDir; })
    (import ./../scripts/theme-selector.nix { inherit pkgs; })
    (import ./../scripts/nvidia-offload.nix { inherit pkgs; })
    (import ./../scripts/web-search.nix { inherit pkgs; })
    (import ./../scripts/rofi-launcher.nix { inherit pkgs; })
    (import ./../scripts/screenshootin.nix { inherit pkgs; })
#    (import ./../scripts/zcc.nix { inherit pkgs; })
  ];

  programs.gh.enable = true;
}
