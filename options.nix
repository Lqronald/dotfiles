# PLEASE READ THE WIKI FOR DETERMINING
# WHAT TO PUT HERE AS OPTIONS. 
# https://gitlab.com/Zaney/zaneyos/-/wikis/Setting-Options

let
  # THINGS YOU NEED TO CHANGE
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
  theme = "evenok-dark";
  slickbar = if waybarStyle == "slickbar" then true else false;
  simplebar = if waybarStyle == "simplebar" then true else false;
  bar-number = true; # Enable / Disable Workspace Numbers In Waybar
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
  clock24h = true;
  theLocale = "en_GB.UTF-8";
  theKBDLayout = "be";
  theSecondKBDLayout = "de";
  theKBDVariant = "";
  theLCVariables = "nl_BE.UTF-8";
  theTimezone = "Europe/Brussels";
  theShell = "bash"; # Possible options: bash, zsh
  theKernel = "default"; # Possible options: default, latest, lqx, xanmod, zen
  sdl-videodriver = "wayland"; # Either x11 or wayland ONLY. Games might require x11 set here
  # For Hybrid Systems intel-nvidia
  # Should Be Used As gpuType
  cpuType = "amd";
  gpuType = "nvidia";

  # Nvidia Hybrid Devices
  # ONLY NEEDED FOR HYBRID
  # SYSTEMS! 
  # intel-bus-id = "PCI:1:0:0";
  # nvidia-bus-id = "PCI:0:2:0";

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
  python = true;

}
