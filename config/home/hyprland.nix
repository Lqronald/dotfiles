{ pkgs, config, lib, inputs, ... }:

let
  theme = config.colorScheme.palette;
  hyprplugins = inputs.hyprland-plugins.packages.${pkgs.system};
  inherit (import ../../options.nix) 
    browser cpuType gpuType
    wallpaperDir borderAnim
    theKBDLayout terminal
    theSecondKBDLayout
    theKBDVariant sdl-videodriver;
in with lib; {
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    plugins = [
      # hyprplugins.hyprtrails
    ];
    extraConfig = let
      modifier = "SUPER";
    in concatStrings [ ''
      monitor=,3840x2160@120,auto,2

      #xwayland {
      #  force_zero_scaling = true
      #}

      exec-once = $POLKIT_BIN
      exec-once = dbus-update-activation-environment --systemd --all
      exec-once = systemctl --user import-environment QT_QPA_PLATFORMTHEME WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      exec-once = swww init
      exec-once = waybar
      exec-once = pypr
      exec-once = swaync
      exec-once = nm-applet --indicator
      exec-once = swayidle -w timeout 1200 'swaylock -f' timeout 1260 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on' before-sleep 'swaylock -f -c 000000'
      #exec-once = hypridle

      dwindle {
        pseudotile = true
        preserve_split = true
      }
      master {
        new_is_master = true
      }

      #windowrule = float, ^(steam)$
      #windowrule = size 1080 900, ^(steam)$
      #windowrule = center, ^(steam)$
      windowrule = fullscreen, ^(wlogout)$
      windowrule = animation fade,^(wlogout)$
      general {
        gaps_in = 4
        gaps_out = 4
        border_size = 1
        col.active_border = rgba(${theme.base0C}ff) rgba(${theme.base0D}ff) rgba(${theme.base0B}ff) rgba(${theme.base0E}ff) 45deg
        col.inactive_border = rgba(${theme.base00}cc) rgba(${theme.base01}cc) 45deg
        layout = dwindle
        resize_on_border = true
      }

      windowrule = float, ^(vlc)$
      windowrule = workspace 2, ^(qBittorrent)$

      $scratchy  = class:^(scratchpad)$
      windowrulev2 = float,$scratchy
      windowrulev2 = size 70% 60%,$scratchy
      windowrulev2 = workspace special:scratch_term silent,$scratchy
      windowrulev2 = center,$scratchy

      input {
        kb_layout = be
        kb_options = grp:alt_shift_toggle
        #kb_options=caps:super
        follow_mouse = 1
        touchpad {
          natural_scroll = false
        }
        sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
        #accel_profile = flat
      }
      env = NIXOS_OZONE_WL, 1
      env = NIXPKGS_ALLOW_UNFREE, 1
      env = XDG_CURRENT_DESKTOP, Hyprland
      env = XDG_SESSION_TYPE, wayland
      env = XDG_SESSION_DESKTOP, Hyprland
      env = GDK_BACKEND, wayland
      env = CLUTTER_BACKEND, wayland
      env = SDL_VIDEODRIVER, ${sdl-videodriver}
      env = QT_QPA_PLATFORM, wayland
      env = QT_WAYLAND_DISABLE_WINDOWDECORATION, 1
      env = QT_AUTO_SCREEN_SCALE_FACTOR, 1
      env = MOZ_ENABLE_WAYLAND, 1
      #env = GDK_DPI_SCALE, 0.5
      env = GDK_SCALE, 2
      ${if cpuType == "vm" then ''
        env = WLR_NO_HARDWARE_CURSORS,1
        env = WLR_RENDERER_ALLOW_SOFTWARE,1
      '' else ''
      ''}
      ${if gpuType == "nvidia" then ''
        env = WLR_NO_HARDWARE_CURSORS,1
      '' else ''
      ''}
      gestures {
        workspace_swipe = true
        workspace_swipe_fingers = 3
      }
      misc {
        mouse_move_enables_dpms = true
        key_press_enables_dpms = false
      }
      animations {
        enabled = yes
        bezier = wind, 0.05, 0.9, 0.1, 1.05
        bezier = winIn, 0.1, 1.1, 0.1, 1.1
        bezier = winOut, 0.3, -0.3, 0, 1
        bezier = liner, 1, 1, 1, 1
        animation = windows, 1, 6, wind, slide
        animation = windowsIn, 1, 6, winIn, slide
        animation = windowsOut, 1, 5, winOut, slide
        animation = windowsMove, 1, 5, wind, slide
        animation = border, 1, 1, liner
        ${if borderAnim == true then ''
          animation = borderangle, 1, 30, liner, loop
        '' else ''
        ''}
        animation = fade, 1, 10, default
        animation = workspaces, 1, 5, wind
      }
      decoration {
        rounding = 10
        drop_shadow = false
        blur {
            enabled = true
            size = 5
            passes = 3
            new_optimizations = on
            ignore_opacity = on
        }
      }
      plugin {
        hyprtrails {
          color = rgba(${theme.base0A}ff)
        }
      }

      bind = ${modifier}, Return, exec, ${terminal}
      bind = ${modifier}, SUPER_L, exec, rofi-launcher
      bind = ${modifier} SHIFT, W, exec, web-search
      bind = ${modifier}, N, exec, swaync-client -rs
        ${if browser == "google-chrome" then ''
          bind = ${modifier}, W, exec, google-chrome-stable
        '' else ''
          bind = ${modifier}, W, exec, ${browser}
        ''}
      bind = , PRINT, exec, screenshootin
      bind = ${modifier}, B, exec, waypaper --random
      bind = ${modifier}, C, exec, waypaper
      bind = ${modifier}, E, exec, emopicker9000
      bind = ${modifier}, D, exec, dolphin
      bind = ${modifier}, G, exec, gimp
      bind = ${modifier}, S, exec, spotify
      bind = ${modifier}, P, pseudo,
      bind = ${modifier}, Q, killactive,
      bind = ${modifier}, R, exec, ~/.dotfiles/config/scripts/rofibeats.sh
      bind = ${modifier} SHIFT, B, exec, ~/.dotfiles/config/scripts/launchwb.sh
      bind = ${modifier} SHIFT, I, togglesplit,
      bind = ${modifier}, F, fullscreen, 1
      bind = ${modifier} SHIFT, F, fullscreen
      bind = ${modifier} SHIFT, T, togglefloating,
      bind = ${modifier}, L, exec, swaylock
      bind = ${modifier} SHIFT, M, exit,

      bind = ${modifier} CTRL, left, movewindow, l
      bind = ${modifier} CTRL, right, movewindow, r
      bind = ${modifier} CTRL, up, movewindow, u
      bind = ${modifier} CTRL, down, movewindow, d
      bind = ${modifier}, left, movefocus, l
      bind = ${modifier}, right, movefocus, r
      bind = ${modifier}, up, movefocus, u
      bind = ${modifier}, down, movefocus, d
      bind = ${modifier} SHIFT, right, resizeactive, 100 0
      bind = ${modifier} SHIFT, left, resizeactive, -100 0
      bind = ${modifier} SHIFT, up, resizeactive, 0 -100
      bind = ${modifier} SHIFT, down, resizeactive, 0 100

      bind = ${modifier}, ampersand, workspace, 1
      bind = ${modifier}, eacute, workspace, 2
      bind = ${modifier}, quotedbl, workspace, 3
      bind = ${modifier}, apostrophe, workspace, 4
      bind = ${modifier}, parenleft, workspace, 5
      bind = ${modifier}, egrave, workspace, 6
      bind = ${modifier}, minus, workspace, 7
      bind = ${modifier}, underscore, workspace, 8
      bind = ${modifier}, ccedilla, workspace, 9
      bind = ${modifier}, agrave, workspace, 10
      bind = ${modifier} SHIFT, ampersand, movetoworkspace, 1
      bind = ${modifier} SHIFT, eacute, movetoworkspace, 2
      bind = ${modifier} SHIFT, quotedbl, movetoworkspace, 3
      bind = ${modifier} SHIFT, apostrophe, movetoworkspace, 4
      bind = ${modifier} SHIFT, parenleft, movetoworkspace, 5
      bind = ${modifier} SHIFT, egrave, movetoworkspace, 6
      bind = ${modifier} SHIFT, minus, movetoworkspace, 7
      bind = ${modifier} SHIFT, underscore, movetoworkspace, 8
      bind = ${modifier} SHIFT, ccedilla, movetoworkspace, 9
      bind = ${modifier} SHIFT, agrave, movetoworkspace, 10
      #bind = ${modifier} CTRL, right, workspace, e+1
      #bind = ${modifier} CTRL, left, workspace, e-1
      bind = ${modifier}, mouse_down, workspace,  e+1
      bind = ${modifier}, mouse_up, workspace,  e-1
      bindm = ${modifier}, mouse:272, movewindow
      bindm = ${modifier}, mouse:273, resizewindow

      bind = ALT, Tab, cyclenext
      bind = ALT, Tab, bringactivetotop
      bind = , F12, exec, pypr toggle term && hyprctl dispatch bringactivetotop

      bind = , XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
      bind = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
      binde = , XF86AudioMute,  exec,  wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      bind = , XF86AudioPlay,  exec,  playerctl play-pause
      bind = , XF86AudioPause,  exec,  playerctl play-pause
      bind = , XF86AudioNext,  exec,  playerctl next
      bind = , XF86AudioPrev,  exec,  playerctl previous
      bind = , XF86MonBrightnessDown, exec, brightnessctl set 5%-
      bind = , XF86MonBrightnessUp, exec, brightnessctl set +5%
    '' ];
  };
}
