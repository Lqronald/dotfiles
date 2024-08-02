{
  pkgs,
  username,
  host,
  ...
}:

{
  # Home Manager Settings
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "24.05";

  # Import Program Configurations
  #imports = [
    #../../config/emoji.nix
    #../../config/hyprland.nix
    #../../config/neovim.nix
    #../../config/rofi/rofi.nix
    #../../config/rofi/config-emoji.nix
    #../../config/rofi/config-long.nix
    #../../config/swaync.nix
    #../../config/waybar.nix
    #../../config/wlogout.nix
  #];

  # Place Files Inside Home Directory
  #home.file."Pictures/Wallpapers" = {
  #  source = ../../config/wallpapers;
  #  recursive = true;
  #};

  #home.file.".face.icon".source = ../../config/face.jpg;
  #home.file.".config/face.jpg".source = ../../config/face.jpg;


  # Install & Configure Git
  programs.git = {
    enable = true;
    userName = "Lqronald";
    userEmail = "lqronald@gmail.com";
  };

  # Create XDG Dirs
  #xdg = {
  #  userDirs = {
  #    enable = true;
  #    createDirectories = true;
  #  };
  #};

  #dconf.settings = {
  #  "org/virt-manager/virt-manager/connections" = {
  #    autoconnect = [ "qemu:///system" ];
  #    uris = [ "qemu:///system" ];
  #  };
  #};

  # For Gnome

  #gtk = {
  #  iconTheme = {
  #    name = "Papirus-Dark";
  #    package = pkgs.papirus-icon-theme;
  #  };
  #  gtk3.extraConfig = {
  #    gtk-application-prefer-dark-theme = 1;
  #  };
  #  gtk4.extraConfig = {
  #    gtk-application-prefer-dark-theme = 1;
  #  };
  #};

  #qt = {
  #  enable = true;
  #  platformTheme.name = "gtk3";
  #  style.name = "adwaita-dark";
  #};

  #qt = {
  #  enable = true;
  #  platformTheme.name = "qtct";
  #  style.name = "kvantum";
  #};

  #xdg.configFile = {
  #  "Kvantum/ArcDark".source = "${pkgs.arc-kde-theme}/share/Kvantum/ArcDark";
  #  "Kvantum/kvantum.kvconfig".text = "[General]\ntheme=ArcDark";
  #};

  # Scripts
  home.packages = [
   # (import ../../scripts/emopicker9000.nix { inherit pkgs; })
   # (import ../../scripts/task-waybar.nix { inherit pkgs; })
   # (import ../../scripts/squirtle.nix { inherit pkgs; })
   # (import ../../scripts/nvidia-offload.nix { inherit pkgs; })
   # (import ../../scripts/wallsetter.nix {
   #   inherit pkgs;
   #   inherit username;
   # })
   # (import ../../scripts/web-search.nix { inherit pkgs; })
   # (import ../../scripts/rofi-launcher.nix { inherit pkgs; })
   # (import ../../scripts/screenshootin.nix { inherit pkgs; })
   # (import ../../scripts/list-hypr-bindings.nix {
   #   inherit pkgs;
   #   inherit host;
   # })
  ];

    programs.gh.enable = true;

    programs.btop = {
      enable = true;
      settings = {
        vim_keys = true;
      };
    };

    programs.alacritty = {
      enable = false;
      settings = {
        window = {
          padding.x = 15;
	      padding.y = 15;
	      decorations = "none";
	      startup_mode = "Windowed";
  	      dynamic_title = true;
          opacity = 0.85;
        };
      cursor = {
	    style = {
	      shape = "Beam";
	      blinking = "On";
	    };
      };
      live_config_reload = true;
      font = {
	    normal.family = "JetBrainsMono Nerd Font";
	    bold.family = "JetBrainsMono Nerd Font";
	    italic.family = "JetBrainsMono Nerd Font";
	    bold_italic.family = "JetBrainsMono Nerd Font";
	    size = 14;
      };
    };
   };

    programs.bash = {
      enable = true;
      enableCompletion = true;
    #  profileExtra = ''
    #    #if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
    #    #  exec Hyprland
    #    #fi
    #  '';
      initExtra = ''
        neofetch
        if [ -f $HOME/.bashrc-personal ]; then
          source $HOME/.bashrc-personal
        fi
      '';
      shellAliases = {
      rebuild="sudo nixos-rebuild switch";
      fu="sudo nix flake update /home/${username}/dotfiles";
      #fr="sudo nixos-rebuild switch --flake . #plasmaNix";
      fr="sudo nixos-rebuild switch --flake . --verbose --show-trace";
      frc="sudo nixos-rebuild switch --flake . --option eval-cache false";
      gens="nix profile history --profile /nix/var/nix/profiles/system";
      prof="cd /nix/var/nix/profiles && ls";
      garbage="nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
      ii="nix-shell -p nix-info --run nix-info -m";
      #ls="lsd";
      #ll="lsd -l";
      #la="lsd -a";
      #lal="lsd -al";
      ls = "eza -a --icons --group-directories-first";
      ll = "eza -al --icons --group-directories-first";
      lt = "eza -a --tree --level=1 --icons --group-directories-first";
      "cd.." = "cd ..";
      df = "df -h";
      cat = "bat";
      sl ="systemctl suspend";
      logout = "qdbus org.kde.Shutdown /Shutdown logout";
      #logout = "pkill -u $USER";
      reboot = "systemctl reboot";
      re = "systemctl reboot";
      shutdown = "systemctl poweroff";
      sd = "systemctl poweroff";
      plasma = "dbus-launch startplasma-wayland";
      dot = "cd ~/dotfiles";
      };
    };

    programs.home-manager.enable = true;
}
