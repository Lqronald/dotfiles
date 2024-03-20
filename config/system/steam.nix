{ pkgs, config, lib, ... }:

{
  # Steam Configuration
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  #environment.sessionVariables = {
  #  STEAM_FORCE_DESKTOPUI_SCALING = "1";
  #};
}
