{ config, lib, pkgs, ... }:

let inherit (import ../../options.nix) flakeDir flakePrev flakeBackup theShell; in
lib.mkIf (theShell == "bash") {
  # Configure Bash
  programs.bash = {
    enable = true;
    enableCompletion = true;
    profileExtra = ''
      #if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
      #  exec Hyprland
      #fi
    '';
    initExtra = ''
      neofetch
      if [ -f $HOME/.bashrc-personal ]; then
        source $HOME/.bashrc-personal
      fi
    '';
    sessionVariables = {
      FLAKEDIR = "${flakeDir}";
      ZANEYOS = true;
      FLAKEBACKUP = "${flakeBackup}";
      FLAKEPREV = "${flakePrev}";
    };
    shellAliases = {
      sv="sudo nvim";
      reflake="sudo nixos-rebuild switch --flake ${flakeDir}";
      flakup="sudo nix flake update ${flakeDir}";
      garbage="nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
      v="nvim";
      #ls="lsd";
      #ll="lsd -l";
      #la="lsd -a";
      #lal="lsd -al";
      ls = "eza -a --icons --group-directories-first";
      ll = "eza -al --icons --group-directories-first";
      lt = "eza -a --tree --level=1 --icons --group-directories-first";
      "cd.." = "cd ..";
      df = "df -h";
      shutdown = "systemctl poweroff";
      dot = "cd ~/.dotfiles";
      hh = "Hyprland";
    };
  };
}
