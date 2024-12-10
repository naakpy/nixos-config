{ config, pkgs, ... }:

{
  home = {
    username = "kaan";
    homeDirectory = "/home/kaan";
    stateVersion = "23.11";
  };
  
  programs.home-manager.enable = true;

  services.mako = {
    enable = true;
    defaultTimeout = 5000;
    backgroundColor = "#151718";
    textColor = "#9FCA56";
    borderColor = "#151718";
  };

  programs.zsh = {
  enable = true;
  enableCompletion = true;
  syntaxHighlighting.enable = true;

  initExtra = ''
      function start_ssh_agent {
        eval "$(ssh-agent -s)" > /dev/null 2>&1
        ssh-add /home/kaan/.ssh/id_home > /dev/null 2>&1
      }

      start_ssh_agent
  '';

  shellAliases = {
    ll = "ls -l";
    direnv = "eval $(direnv hook zsh)";
    update = "(cd ~/nixos-config && gwip && gp && git pull && nix flake update && sudo nixos-rebuild switch --flake .)";

  };
  history = {
    size = 10000;
    path = "${config.xdg.dataHome}/zsh/history";
  };
  oh-my-zsh = {
    enable = true;
    plugins = [ "git" ];
    theme = "robbyrussell";
  };
  };

  programs.kitty.enable = true;
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
    # See https://wiki.hyprland.org/Configuring/Monitors/
	# Set DP-3 as the primary monitor (center)
	monitor = DP-1, 3440x1440@144, 0x0, 1  # Primary monitor (landscape)

	# Set DP-2 to the left of the primary monitor and rotate it to portrait
	monitor = DP-2, 2560x1440@144, -1440x-900, 1, transform, 1

	# Set HDMI-A-1 to the right of the primary monitor and rotate it to portrait
	monitor = DP-3, 2560x1440@144, 3440x-900, 1, transform, 3

	# unscale XWayland
	xwayland {
	  force_zero_scaling = true
	}


	# See https://wiki.hyprland.org/Configuring/Keywords/ for more

	# Execute your favorite apps at launch
	# exec-once = waybar & hyprpaper & firefox

	# Source a file (multi-file configs)
	# source = ~/.config/hypr/myColors.conf

	# Some default env vars.
	env = XCURSOR_SIZE,24

	# For all categories, see https://wiki.hyprland.org/Configuring/Variables/
	input {
	    kb_layout = us
	    kb_variant =
	    kb_model =
	    kb_options =
	    kb_rules =

	    follow_mouse = 1

	    touchpad {
		natural_scroll = no
	    }

	    sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
	}

	general {
	    # See https://wiki.hyprland.org/Configuring/Variables/ for more

	    gaps_in = 0
	    gaps_out = 0
	    border_size = 2
	    col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
	    col.inactive_border = rgba(595959aa)

	    layout = dwindle

	    # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
	    allow_tearing = false
	}

	decoration {
	    # See https://wiki.hyprland.org/Configuring/Variables/ for more

	    rounding = 0
	    
	    blur {
		enabled = true
		size = 3
		passes = 1
	    }

	}

	animations {
	    enabled = yes

	    # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

	    bezier = myBezier, 0.05, 0.9, 0.1, 1.05

	    animation = windows, 1, 7, myBezier
	    animation = windowsOut, 1, 7, default, popin 80%
	    animation = border, 1, 10, default
	    animation = borderangle, 1, 8, default
	    animation = fade, 1, 7, default
	    animation = workspaces, 1, 6, default
	}

	dwindle {
	    # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
	    pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
	    preserve_split = yes # you probably want this
	}

	gestures {
	    # See https://wiki.hyprland.org/Configuring/Variables/ for more
	    workspace_swipe = on
	}

	misc {
	    # See https://wiki.hyprland.org/Configuring/Variables/ for more
	    force_default_wallpaper = 0 # Set to 0 to disable the anime mascot wallpapers
	}


	# Example windowrule v1
	# windowrule = float, ^(kitty)$
	# Example windowrule v2
	# windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
	# See https://wiki.hyprland.org/Configuring/Window-Rules/ for more


	# See https://wiki.hyprland.org/Configuring/Keywords/ for more
	$mainMod = Alt

	# Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
	bind = $mainMod, Return, exec, kitty
	bind = $mainMod SHIFT, Q, killactive, 
	bind = $mainMod, M, exit, 
	bind = $mainMod, E, exec, dolphin
	bind = $mainMod, V, togglefloating, 
	bind = $mainMod, R, exec, rofi -show drun
	bind = $mainMod, P, pseudo, # dwindle
	bind = $mainMod, J, togglesplit, # dwindle
	bind = $mainMod, F, fullscreen

	# Move focus with mainMod + arrow keys
	bind = $mainMod, left, movefocus, l
	bind = $mainMod, right, movefocus, r
	bind = $mainMod, up, movefocus, u
	bind = $mainMod, down, movefocus, d

	bind = CTRL $mainMod, comma, movecurrentworkspacetomonitor, l
	bind = CTRL $mainMod, period, movecurrentworkspacetomonitor, r 

	bind=,XF86MonBrightnessDown,exec,brightnessctl set 5%-
	bind=,XF86MonBrightnessUp,exec,brightnessctl set +5% 

	# Screenshot a window
	bind = $mainMod, PRINT, exec, hyprshot -m window
	# Screenshot a monitor
	bind = , PRINT, exec, hyprshot -m output
	# Screenshot a region
	bind = $shiftMod, PRINT, exec, hyprshot -m region

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

	# Example special workspace (scratchpad)
	bind = $mainMod, S, togglespecialworkspace, magic
	bind = $mainMod SHIFT, S, movetoworkspace, special:magic

	# Scroll through existing workspaces with mainMod + scroll
	bind = $mainMod, mouse_down, workspace, e+1
	bind = $mainMod, mouse_up, workspace, e-1

	# Move/resize windows with mainMod + LMB/RMB and dragging
	bindm = $mainMod, mouse:272, movewindow
	bindm = $mainMod, mouse:273, resizewindow
	
	exec-once swww init & swww img ~/.config/hypr/background.jpg &
    '';
  };
}
