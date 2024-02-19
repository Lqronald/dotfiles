# PLEASE READ THE WIKI FOR DETERMINING
# VALUES FOR THIS PAGE. 
# https://gitlab.com/Zaney/zaneyos/-/wikis/Setting-Options

let
  username = "ronald";
  hostname = "hyprnix";
  userHome = "/home/${username}";
  flakeDir = "${userHome}/.dotfiles";
  waybarStyle = "slickbar"; # simplebar, slickbar, or default
in {
  # User Variables
  username = "${username}";
  hostname = "${hostname}";
  gitUsername = "Lqronald";
  gitEmail = "lqronald@gmail.com";
  theme = "gigavolt";
  slickbar = if waybarStyle == "slickbar" then true else false;
  simplebar = if waybarStyle == "simplebar" then true else false;
  borderAnim = true;
  browser = "firefox";
  wallpaperGit = "https://github.com/Lqronald/Wallpapers.git"; # This will give you my wallpapers
  # ^ (use as is or replace with your own repo - removing will break the wallsetter script) 
  wallpaperDir = "${userHome}/Pictures/Wallpapers";
  screenshotDir = "${userHome}/Pictures/Screenshots";
  flakeDir = "${flakeDir}";
  flakePrev = "${userHome}/nix.previous";
  flakeBackup = "${userHome}/nix.backup";
  terminal = "alacritty"; # This sets the terminal that is used by the hyprland terminal keybinding

  # System Settings
  clock24h = false;
  theLocale = "en_GB.UTF-8";
  theKBDLayout = "be";
  theSecondKBDLayout = "de";
  theKBDVariant = "";
  theLCVariables = "nl_BE.UTF-8";
  theTimezone = "Europe/Brussels";
  theShell = "bash"; # Possible options: bash, zsh
  theKernel = "default"; # Possible options: default, latest, lqx, xanmod, zen
  # This is for running NixOS
  # On a tmpfs or root on RAM
  # You Most Like Want This -> false
  impermanence = false; # This should be set to false unless you know what your doing!
  sdl-videodriver = "wayland"; # Either x11 or wayland ONLY. Games might require x11 set here
  # For Hybrid Systems intel-nvidia
  # Should Be Used As gpuType
  cpuType = "amd";
  gpuType = "nvidia";

  # Nvidia Hybrid Devices
  # ONLY NEEDED FOR HYBRID
  # SYSTEMS! 
  #intel-bus-id = "PCI:0:2:0";
  #nvidia-bus-id = "PCI:14:0:0";

  # Enable / Setup NFS
  nfs = false;
  #nfsMountPoint = "/mnt/nas";
  #nfsDevice = "nas:/volume1/nas";

  # NTP & HWClock Settings
  ntp = true;
  localHWClock = false;

  # Enable Printer & Scanner Support
  printer = false;

  # Enable Flatpak & Larger Programs
  flatpak = false;
  kdenlive = false;
  blender = false;

  # Enable Support For
  # Logitech Devices
  logitech = true;

  # Enable Terminals
  # If You Disable All You Get Kitty
  wezterm = false;
  alacritty = true;
  kitty = false;

  # Enable Python & PyCharm
  python = false;

}
