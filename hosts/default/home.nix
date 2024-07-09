{
  pkgs,
  username,
  host,
  ...
}:
let
  inherit (import ./variables.nix) gitUsername gitEmail;
in
{
  # Home Manager Settings
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "24.05";

  # Import Program Configurations
  imports = [
    #../../config/emoji.nix
    #../../config/hyprland.nix
    #../../config/neovim.nix
    #../../config/rofi/rofi.nix
    #../../config/rofi/config-emoji.nix
    #../../config/rofi/config-long.nix
    #../../config/swaync.nix
    #../../config/waybar.nix
    #../../config/wlogout.nix
  ];

  # Place Files Inside Home Directory
  #home.file."Pictures/Wallpapers" = {
  #  source = ../../config/wallpapers;
  #  recursive = true;
  #};
  home.file.".config/neofetch/config.conf".text = ''
        print_info() {
            info "$(color 6)  OS " distro
            info underline
            info "$(color 7)  VER" kernel
            info "$(color 2)  UP " uptime
            info "$(color 4)  PKG" packages
            info "$(color 6)  DE " de
            info "$(color 5)  TER" term
            info "$(color 3)  CPU" cpu
            info "$(color 7)  GPU" gpu
            info "$(color 5)  MEM" memory
            prin " "
            prin "$(color 1) $(color 2) $(color 3) $(color 4) $(color 5) $(color 6) $(color 7) $(color 8)"
        }
        distro_shorthand="on"
        memory_unit="gib"
        cpu_temp="C"
        separator=" $(color 4)>"
        stdout="off"
    '';
  #home.file.".face.icon".source = ../../config/face.jpg;
  #home.file.".config/face.jpg".source = ../../config/face.jpg;


  # Install & Configure Git
  programs.git = {
    enable = true;
    userName = "${gitUsername}";
    userEmail = "${gitEmail}";
  };

  # Create XDG Dirs
  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  gtk = {
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };
  qt = {
    enable = true;
    style.name = "adwaita-dark";
    platformTheme.name = "gtk3";
  };


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
      enable = true;
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
        fastfetch
        if [ -f $HOME/.bashrc-personal ]; then
          source $HOME/.bashrc-personal
        fi
      '';
      shellAliases = {
      rebuild="sudo nixos-rebuild switch";
      fu="sudo nix flake update /home/${username}/.dotfiles";
      fr="sudo nixos-rebuild switch --flake .";
      frc="sudo nixos-rebuild switch --flake . --option eval-cache false";
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
      reboot = "systemctl reboot";
      re = "systemctl reboot";
      shutdown = "systemctl poweroff";
      sd = "systemctl poweroff";
      dot = "cd ~/.dotfiles";
      };
    };

    programs.home-manager.enable = true;
}
