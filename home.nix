{ config, pkgs, inputs, username,
  gtkThemeFromScheme, ... }:
let 
  inherit (import ./options.nix)
    gitUsername gitEmail theme browser 
    wallpaperDir flakeDir waybarStyle;
in {
  # Home Manager Settings
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "24.05";

  # Set The Colorscheme
  colorScheme = inputs.nix-colors.colorSchemes."${theme}";

  # Import Program Configurations
  imports = [
    inputs.nix-colors.homeManagerModules.default
  #  inputs.hyprland.homeManagerModules.default
    ./config/home
  ];

  # Install & Configure Git
  programs.git = {
    enable = true;
    userName = "${gitUsername}";
    userEmail = "${gitEmail}";
  };

  # Create XDG Dirs
  #xdg = {
  #  userDirs = {
  #      enable = true;
  #      createDirectories = true;
  #  };
  #};

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

  programs.home-manager.enable = true;
}
