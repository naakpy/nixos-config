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
  
  home.packages = with pkgs; [
    waybar
  ];
  home.file.".config/waybar/config".text = ''
    {
	 "layer": "top", "position": "top",
	 "modules-left": ["custom/logo", "clock",  "custom/weather", "disk", "memory", "cpu", "temperature", "custom/powerDraw", "hyprland/window" ],
	 "modules-center": [  "hyprland/workspaces"],
	 "modules-right": ["tray",  "custom/clipboard", "backlight", "idle_inhibitor", "bluetooth", "pulseaudio",  "battery" ],
	 "reload_style_on_change":true,

	 "custom/logo": {
	   "format": "",
	   "tooltip": false
	 },

	 "hyprland/workspaces": {
		"format": "{icon}",
		"format-icons": {
			"1": "",
			"2": "",
			"3": "",
			"4": "",
			"5": "",
			"6": "",
			"active": "",
			"default": "" 
		},
	      "persistent-workspaces": {
		"*": [ 2, 3, 4, 5, 6 ]
	      }
	},

	"idle_inhibitor":{
	 "format": "<span font='12'>{icon} </span>",
	 "format-icons": {
	   "activated":"󰈈",
	   "deactivated":"󰈉"
	 }
	},

	"custom/weather": {
	 "format": "{}",
	 "return-type": "json",
	 "exec": "/etc/nixos/modules/scripts/weather.sh",
	 "interval": 10,
	 "on-click": "librewolf https://wttr.in"
	},

	"custom/clipboard":{
	 "format":"",
	 "on-click": "cliphist list | rofi -dmenu | cliphist decode | wl-copy",
	 "interval":86400
	},


	"clock": {
	     "format": "{:%I:%M:%S %p}",
	     "interval":1,
	     "tooltip-format": "\n<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>",
	     "calendar-weeks-pos": "right",
	     "today-format": "<span color='#7645AD'><b><u>{}</u></b></span>",
	     "format-calendar": "<span color='#aeaeae'><b>{}</b></span>",
	     "format-calendar-weeks": "<span color='#aeaeae'><b>W{:%V}</b></span>",
	     "format-calendar-weekdays": "<span color='#aeaeae'><b>{}</b></span>"
	     },

	 "bluetooth": {
	 "format-on": "",
	 "format-off": "",
	 "format-disabled": "󰂲",
	 "format-connected": "󰂴",
	 "format-connected-battery": "{device_battery_percentage}% 󰂴",
	 "tooltip-format": "{controller_alias}\t{controller_address}\n\n{num_connections} connected",
	 "tooltip-format-connected": "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}",
	 "tooltip-format-enumerate-connected": "{device_alias}\t{device_address}",
	 "tooltip-format-enumerate-connected-battery": "{device_alias}\t{device_address}\t{device_battery_percentage}%",
	 "on-click": "kitty bluetoothctl",
	}, 

	"network": {
	     "format-wifi": " ",
	     "format-ethernet":" ",
	     "format-disconnected": "",
	     "tooltip-format": "{ipaddr}",
	     "tooltip-format-wifi": "{essid} ({signalStrength}%)  | {ipaddr}",
	     "tooltip-format-ethernet": "{ifname} 🖧 | {ipaddr}",
	     "on-click": "kitty nmtui-connect"
	   },

	"battery": {
	   "interval":1,
		"states": {
		   "good": 95,
		   "warning": 30,
		   "critical": 20
		},
		"format": "{capacity}%  {icon} ",
		"format-charging": "{capacity}% 󰂄 ",
		"format-plugged": "{capacity}% 󰂄 ",
		"format-alt": "{time} {icon}",
		   "format-icons": [
		 "󰁻",
		 "󰁼",
		 "󰁾",
		 "󰂀",
		 "󰂂",
		 "󰁹"
		],
	   },
	"backlight": {
	 "device": "intel_backlight",
	 "format": "<span font='12'>{icon}</span>",
	 "format-icons": [
	   "",
	   "",
	   "",
	   "",
	   "",
	   "",
	   "",
	   "",
	   "",
	   "",
	 ],
	 "on-scroll-down": "brightnessctl set 5%+",
	 "on-scroll-up": "brightnessctl set 5%-",
	 "smooth-scrolling-threshold": 1
	 },

	"disk": {
	   "interval": 30,
	   "format": "  {percentage_used}%",
	   "path": "/"
	 },

	 "cpu": {
	     "interval": 1,
	     "format": " {usage}%",
	     "min-length": 6,
	     "max-length": 6,
	     "format-icons": ["▁", "▂", "▃", "▄", "▅", "▆", "▇", "█"],
	     "on-click": "kitty btop" 
	},
	"memory": {
	 "format": " {percentage}%"
	},

	"hyprland/window": {
	   "format": "( {class} )",
	   "rewrite": {
		"(.*) - Librewolf": "🌎 $1",
		"(.*) - zsh": "> [$1]"
	   }
	},

	"temperature": {
	 "format": " {temperatureC}°C",            
	 "format-critical": " {temperatureC}°C",
	 "interval": 1,
	 "critical-threshold": 80,
	 "on-click": "kitty btop",
	},

	"pulseaudio": {
	 "format": "{volume}% {icon}",
	 "format-bluetooth":"󰂰",
	 "format-muted": "<span font='12'></span>",
	 "format-icons": {
	   "headphones": "",
	   "bluetooth": "󰥰",
	   "handsfree": "",
	   "headset": "󱡬",
	   "phone": "",
	   "portable": "",
	   "car": "",
	   "default": ["🕨","🕩","🕪"]
	 },
	 "justify": "center",
	 "on-click": "pavucontrol",
	 "tooltip-format": "{icon}  {volume}%"
	},

	"jack": {
	   "format": "{} 󱎔",
	   "format-xrun": "{xruns} xruns",
	   "format-disconnected": "DSP off",
	   "realtime": true
	},

	"tray": {
	   "icon-size": 14,
	   "spacing": 10
	},

	"upower": {
	   "show-icon": false,
	   "hide-if-empty": true,
	   "tooltip": true,
	   "tooltip-spacing": 20
	},

	 "custom/powerDraw": {
	   "format": "{}",
	   "interval": 1,
	   "exec": "/etc/nixos/modules/scripts/powerdraw.sh",
	   "return-type": "json"
	 }

	}

  '';

  home.file.".config/waybar/style.css".text = ''
	* {
	   border: none;
	   font-size: 14px;
	   font-family: "JetBrainsMono Nerd Font,JetBrainsMono NF" ;
	   min-height: 25px;
	}

	window#waybar {
	 background: transparent;
	 margin: 5px;
	}

	#custom-logo {
	 padding: 0 10px;
	}

	.modules-right {
	 padding-left: 5px;
	 border-radius: 15px 0 0 15px;
	 margin-top: 2px;
	 background: #000000;
	}

	.modules-center {
	 padding: 0 15px;
	 margin-top: 2px;
	 border-radius: 15px 15px 15px 15px;
	 background: #000000;
	}

	.modules-left {
	 border-radius: 0 15px 15px 0;
	 margin-top: 2px;
	 background: #000000;
	}

	#battery,
	#custom-clipboard,
	#custom-colorpicker,
	#custom-powerDraw,
	#bluetooth,
	#pulseaudio,
	#network,
	#disk,
	#memory,
	#backlight,
	#cpu,
	#temperature,
	#custom-weather,
	#idle_inhibitor,
	#jack,
	#tray,
	#window,
	#workspaces,
	#clock {
	 padding: 0 5px;
	}
	#pulseaudio {
	 padding-top: 3px;
	}

	#temperature.critical,
	#pulseaudio.muted {
	 color: #FF0000;
	 padding-top: 0;
	}




	#clock{
	 color: #5fd1fa;
	}

	#battery.charging {
	   color: #ffffff;
	   background-color: #26A65B;
	}

	#battery.warning:not(.charging) {
	   background-color: #ffbe61;
	   color: black;
	}

	#battery.critical:not(.charging) {
	   background-color: #f53c3c;
	   color: #ffffff;
	   animation-name: blink;
	   animation-duration: 0.5s;
	   animation-timing-function: linear;
	   animation-iteration-count: infinite;
	   animation-direction: alternate;
	}


	@keyframes blink {
	   to {
		background-color: #ffffff;
		color: #000000;
	   }
	}  

  '';
}



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
	
	exec-once = swww init & swww img ~/.config/hypr/background.jpg &
    '';
  };
}
