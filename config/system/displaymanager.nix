{ pkgs, config, username, ... }:

let inherit (import ../../options.nix) theKBDVariant theKBDLayout theSecondKBDLayout;
in
{
  services.xserver = {
    enable = true;
    dpi = 192;
    xkb = {
      layout = "${theKBDLayout}";
      variant = "";
    };
    libinput.enable = true;

    displayManager.sddm = {
      enable = true;
      autoNumlock = true;
      enableHidpi = true;
      wayland.enable = true;
      theme = "sugar-dark";
    };

    displayManager.autoLogin.enable = true;
    displayManager.autoLogin.user = "${username}";
  };

  environment.systemPackages =
let
    sugar = pkgs.callPackage ../pkgs/sddm-sugar-dark.nix {};
    tokyo-night = pkgs.libsForQt5.callPackage ../pkgs/sddm-tokyo-night.nix {};
in [ 
    sugar.sddm-sugar-dark # Name: sugar-dark
    tokyo-night # Name: tokyo-night-sddm
    pkgs.libsForQt5.qt5.qtgraphicaleffects
  ];
}
