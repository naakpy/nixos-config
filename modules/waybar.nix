{ config, lib, pkgs, ... }:

{
  programs.waybar.enable = true;

  environment.etc."xdg/waybar/config".text = ''
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

  environment.etc."xdg/waybar/style.css".text = ''
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
