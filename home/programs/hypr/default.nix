{ config, lib, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    extraConfig = ''

    # Monitor
    
    monitor = DP-1, 3440x1440@144, 0x0, 1
    monitor = DP-2, 2560x1440@144, -1440x-850, 1, transform, 1
    monitor = DP-3, 2560x1440@144, 3440x-850, 1, transform, 3


    monitor = eDP-1, 2880x1800@120, auto, 1.5
    
    misc {
      disable_splash_rendering = true
      disable_hyprland_logo = true
    }

    xwayland {
        force_zero_scaling = true
    }

    env = GDK_BACKEND,wayland,x11,*
    env = QT_QPA_PLATFORM,wayland;xcb
    env = SDL_VIDEODRIVER,wayland
    env = CLUTTER_BACKEND,wayland

    env = XDG_CURRENT_DESKTOP,Hyprland
    env = XDG_SESSION_TYPE,wayland
    env = XDG_SESSION_DESKTOP,Hyprland

    env = GDK_SCALE,2
      
    env = HYPRCURSOR_THEME,Bibata-Original-Amber
    env = HYPRCURSOR_SIZE,20
    env = XCURSOR_THEME,Bibata-Original-Amber
    env = XCURSOR_SIZE,20

    # Autostart
    exec-once = hyprctl setcursor Bibata-Original-Amber 20
    exec-once = dunst
    exec-once = swww-daemon
    exec-once = nm-applet
    exec-once = gsettings set org.gnome.desktop.interface cursor-theme Bibata-Original-Amber
    exec-once = gsettings set org.gnome.desktop.interface cursor-size 20

    source = /home/kaan/.config/hypr/colors
    exec = pkill waybar & sleep 0.5 && waybar
    exec = sleep 0.5 && swww img --resize fill ~/nixos-config/home/wallpapers/wallpaper.png

    # Set en layout at startup

    # Input config
    input {
        kb_layout = us
        kb_variant =
        kb_model =
        kb_options =
        kb_rules =
        
        kb_options = altwin:swap_alt_win
          
        follow_mouse = 1

        touchpad {
            natural_scroll = false
        }

        sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
    }

    general {

        gaps_in = 1
        gaps_out = 0
        border_size = 2
        col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
        col.inactive_border = rgba(595959aa)

        layout = dwindle
    }

    animations {
        enabled = true

        bezier = ease,0.4,0.02,0.21,1

        animation = windows, 1, 3.5, ease, slide
        animation = windowsOut, 1, 3.5, ease, slide
        animation = border, 1, 6, default
        animation = fade, 1, 3, ease
        animation = workspaces, 1, 3.5, ease
    }

    dwindle {
        pseudotile = yes
        preserve_split = yes
    }

    master {
        new_status = master
    }

    gestures {
        workspace_swipe = true
    }

    # Example windowrule v1
    # windowrule = float, ^(kitty)$
    # Example windowrule v2
    # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$

    $mainMod = SUPER
    bind = $mainMod, F, fullscreen,


    bind = $mainMod, RETURN, exec, kitty
    bind = $mainMod, G, exec, librewolf 
    bind = $mainMod, Q, killactive,
    bind = $mainMod, M, exit,
    bind = $mainMod, V, togglefloating,
    bind = $mainMod, R, exec, rofi -show drun
    bind = $mainMod, P, pseudo, # dwindle
    bind = $mainMod, J, togglesplit, # dwindle

    # Functional keybinds
    bind =,XF86AudioMicMute,exec,pamixer --default-source -t
    bind =,XF86MonBrightnessDown,exec,brightnessctl set 5%-
    bind =,XF86MonBrightnessUp,exec,brightnessctl set 5%+
    bind =,XF86AudioMute,exec,pamixer -t
    bind =,XF86AudioLowerVolume,exec,pamixer -d 5
    bind =,XF86AudioRaiseVolume,exec,pamixer -i 5
    bind =,XF86AudioPlay,exec,playerctl play-pause
    bind =,XF86AudioPause,exec,playerctl play-pause

    # Screenshot binds
    bind =, Print, exec, hyprshot -m output -m active
    bind = SHIFT, Print, exec, hyprshot -m region

    bind = $mainMod, L, exec, hyprlock

    # to switch between windows in a floating workspace
    bind = SUPER,Tab,cyclenext,
    bind = SUPER,Tab,bringactivetotop,

    # Move focus with mainMod + arrow keys
    bind = $mainMod, left, movefocus, l
    bind = $mainMod, right, movefocus, r
    bind = $mainMod, up, movefocus, u
    bind = $mainMod, down, movefocus, d

    # Switch workspaces with mainMod + [0-9]
    bind = $mainMod, 1, workspace, 1
    bind = $mainMod, 2, workspace, 2
    bind = $mainMod, 3, workspace, 3
    bind = $mainMod, 4, workspace, 4
    bind = $mainMod, 5, workspace, 5
    bind = $mainMod, 6, workspace, 6
    bind = $mainMod, 7, workspace, 7
    bind = $mainMod, 8, workspace, 8
    bind = $mainMod, 9, workspace, 9
    bind = $mainMod, 0, workspace, 10

    # Move active window to a workspace with mainMod + SHIFT + [0-9]
    bind = $mainMod SHIFT, 1, movetoworkspace, 1
    bind = $mainMod SHIFT, 2, movetoworkspace, 2
    bind = $mainMod SHIFT, 3, movetoworkspace, 3
    bind = $mainMod SHIFT, 4, movetoworkspace, 4
    bind = $mainMod SHIFT, 5, movetoworkspace, 5
    bind = $mainMod SHIFT, 6, movetoworkspace, 6
    bind = $mainMod SHIFT, 7, movetoworkspace, 7
    bind = $mainMod SHIFT, 8, movetoworkspace, 8
    bind = $mainMod SHIFT, 9, movetoworkspace, 9
    bind = $mainMod SHIFT, 0, movetoworkspace, 10

    # Scroll through existing workspaces with mainMod + scroll
    bind = $mainMod, mouse_down, workspace, e+1
    bind = $mainMod, mouse_up, workspace, e-1

    # Move/resize windows with mainMod + LMB/RMB and dragging
    bindm = $mainMod, mouse:272, movewindow
    bindm = $mainMod, mouse:273, resizewindow
    bindm = ALT, mouse:272, resizewindow
        '';
  };

    home.file.".config/hypr/colors".text = ''
      $background = rgba(1d192bee)
      $foreground = rgba(c3dde7ee)
      $color0 = rgba(1d192bee)
      $color1 = rgba(465EA7ee)
      $color2 = rgba(5A89B6ee)
      $color3 = rgba(6296CAee)
      $color4 = rgba(73B3D4ee)
      $color5 = rgba(7BC7DDee)
      $color6 = rgba(9CB4E3ee)
      $color7 = rgba(c3dde7ee)
      $color8 = rgba(889aa1ee)
      $color9 = rgba(465EA7ee)
      $color10 = rgba(5A89B6ee)
      $color11 = rgba(6296CAee)
      $color12 = rgba(73B3D4ee)
      $color13 = rgba(7BC7DDee)
      $color14 = rgba(9CB4E3ee)
      $color15 = rgba(c3dde7ee)
  '';

  programs.hyprlock = {
    enable = true;
    extraConfig = ''
      # BACKGROUND
  background {
      monitor =
      path = ~/nixos-config/home/wallpapers/wallpaper.png
      blur_passes = 3
      contrast = 0.8916
      brightness = 0.8172
      vibrancy = 0.1696
      vibrancy_darkness = 0.0
  }

  # GENERAL
  general {
      no_fade_in = false
      grace = 0
      disable_loading_bar = true
  }

  # INPUT FIELD
  input-field {
      monitor =
      size = 250, 60
      outline_thickness = 2
      dots_size = 0.2 # Scale of input-field height, 0.2 - 0.8
      dots_spacing = 0.2 # Scale of dots' absolute size, 0.0 - 1.0
      dots_center = true
      outer_color = rgba(0, 0, 0, 0)
      inner_color = rgba(0, 0, 0, 0.5)
      font_color = rgb(200, 200, 200)
      fade_on_empty = false
      font_family = JetBrains Mono Nerd Font Mono
      placeholder_text = <span foreground="##cdd6f4">Input Password</span> #text for input password
      hide_input = false
      position = 0, -120
      halign = center
      valign = center
  }

  # TIME
  label {
      monitor =
      text = cmd[update:1000] echo "$(date +"%H:%M")" # get formatted date
      color = rgba(255, 255, 255, 0.9)
      font_size = 120
      font_family = JetBrains Mono Nerd Font Mono ExtraBold
      position = 0, -300
      halign = center
      valign = top
  }

  # USER
  label {
      monitor =
      text = cmd[update:100] echo "$USER"
      color = rgba(255, 255, 255, 0.9)
      font_size = 25
      font_family = JetBrains Mono Nerd Font Mono
      position = 0, -40
      halign = center
      valign = center
  }
    '';
  };
}
