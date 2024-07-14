{
  config,
  pkgs,
  host,
  username,
  options,
  ...
}:

{
  imports = [
    ./hardware.nix
    ./software.nix
    ./users.nix
    ../../modules/amd-drivers.nix
    ../../modules/nvidia-drivers.nix
    ../../modules/nvidia-prime-drivers.nix
    ../../modules/intel-drivers.nix
    ../../modules/vm-guest-services.nix
    ../../modules/local-hardware-clock.nix
  ];

  boot = {
    # Kernel
    #kernelPackages = pkgs.linuxPackages_zen;
    kernelPackages = pkgs.linuxPackages;
    # Needed For Some Steam Games
    kernel.sysctl = {
      "vm.max_map_count" = 1048576;
    };
    # Bootloader.
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    kernel.sysctl."kernel.sysrq" = 1;

    plymouth.enable = true;
    #plymouth.theme = "bgrt";
    #initrd.verbose = false;
    #consoleLogLevel = 0;
    #kernelParams = [ "quiet" "udev.log_level=0" ];

    # Appimage Support
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
    };
  };

  # OpenGL
  hardware.graphics = {
    enable = true;
  };

  # Extra Module Options
  drivers.amdgpu.enable = false;
  drivers.nvidia.enable = true;
  drivers.nvidia-prime = {
    enable = false;
    intelBusID = "";
    nvidiaBusID = "";
  };
  drivers.intel.enable = false;
  vm.guest-services.enable = false;
  local.hardware-clock.enable = false;

  # Set your time zone.
  time.timeZone = "Europe/Brussels";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_BE.UTF-8";
    LC_IDENTIFICATION = "nl_BE.UTF-8";
    LC_MEASUREMENT = "nl_BE.UTF-8";
    LC_MONETARY = "nl_BE.UTF-8";
    LC_NAME = "nl_BE.UTF-8";
    LC_NUMERIC = "nl_BE.UTF-8";
    LC_PAPER = "nl_BE.UTF-8";
    LC_TELEPHONE = "nl_BE.UTF-8";
    LC_TIME = "nl_BE.UTF-8";
  };

  console.keyMap = "be-latin1";

  fonts = {
    packages = with pkgs; [
      noto-fonts-emoji
      noto-fonts-cjk
      font-awesome
      inter
      symbola
      material-icons
    ];
  };

  nixpkgs.config.allowUnfree = true;

  # Extra Portal Configuration
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
  };

  # Services to start
  services = {
    xserver = {
      enable = true;
      dpi = 192;
      xkb = {
        layout = "be";
        variant = "";
      };
    };

    #smartd = {
    #  enable = false;
    #  autodetect = true;
    #};
    #libinput.enable = true;
    openssh.enable = true;
    printing = {
      enable = false;
      drivers = [
        # pkgs.hplipWithPlugin 
      ];
    };
    #ipp-usb.enable = false;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    rpcbind.enable = true;
    #nfs.server.enable = false;
    flatpak.enable = true;
  };

  systemd.services.flatpak-repo = {
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  #services.displayManager.defaultSession = "plasma";
  services.desktopManager.plasma6.enable = true;
  services.desktopManager.plasma6.enableQt5Integration = true;
  
  #hardware.sane = {
  #  enable = true;
  #  extraBackends = [ pkgs.sane-airscan ];
  # disabledDefaultBackends = [ "escl" ];
  #};

  # Extra Logitech Support
  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true;

  # Bluetooth Support
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Security / Polkit
  security.rtkit.enable = true;
  #security.polkit.enable = true;
  #security.polkit.extraConfig = ''
  #  polkit.addRule(function(action, subject) {
  #    if (
  #      subject.isInGroup("users")
  #        && (
  #          action.id == "org.freedesktop.login1.reboot" ||
  #          action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
  #          action.id == "org.freedesktop.login1.power-off" ||
  #          action.id == "org.freedesktop.login1.power-off-multiple-sessions"
  #        )
  #      )
  #    {
  #      return polkit.Result.YES;
  #    }
  #  })
  #'';

  # Optimization settings and garbage collection automation
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };

    gc = {
      automatic = false;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Virtualization / Containers
  virtualisation.libvirtd.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };

   # Enable networking
  networking.networkmanager.enable = true;
  networking.hostName = host;
  #networking.timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
