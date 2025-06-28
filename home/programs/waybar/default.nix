{ config, lib, pkgs, ... }:

{
  programs.waybar = {
    enable = true;

    style = ''
* {
  min-height: 0;
  min-width: 0;
  font-family: Lexend, "JetBrainsMono NFP";
  font-size: 16px;
  font-weight: 600;
}

window#waybar {
  transition-property: background-color;
  transition-duration: 0.5s;
  /* background-color: #1e1e2e; */
  /* background-color: #181825; */
  background-color: #11111b;
  /* background-color: rgba(24, 24, 37, 0.6); */
}

#workspaces button {
  padding: 0.3rem 0.6rem;
  margin: 0.4rem 0.25rem;
  border-radius: 6px;
  /* background-color: #181825; */
  background-color: #1e1e2e;
  color: #cdd6f4;
}

#workspaces button:hover {
  color: #1e1e2e;
  background-color: #cdd6f4;
}

#workspaces button.active {
  background-color: #1e1e2e;
  color: #89b4fa;
}

#workspaces button.urgent {
  background-color: #1e1e2e;
  color: #f38ba8;
}

#clock,
#pulseaudio,
#custom-logo,
#custom-power,
#custom-spotify,
#custom-notification,
#cpu,
#battery,
#tray,
#memory,
#window,
#backlight,
#mpris {
  padding: 0.3rem 0.6rem;
  margin: 0.4rem 0.25rem;
  border-radius: 6px;
  /* background-color: #181825; */
  background-color: #1e1e2e;
}

#mpris.playing {
  color: #a6e3a1;
}

#mpris.paused {
  color: #9399b2;
}

#custom-sep {
  padding: 0px;
  color: #585b70;
}

window#waybar.empty #window {
  background-color: transparent;
}

#cpu {
  color: #94e2d5;
}

#memory {
  color: #cba6f7;
}

#clock {
  color: #74c7ec;
}

#battery {
  color: #a6e3a1;
}

#backlight {
  color: #f38ba8;
}

#battery.warning {
  color: #f9e2af;
}

#battery.critical {
  color: #f38ba8;
  animation-name: blink;
  animation-duration: 0.5s;
  animation-timing-function: linear;
  animation-iteration-count: infinite;
  animation-direction: alternate;
}

@keyframes blink {
  to {
    background-color: #f38ba8;
    color: #1e1e2e;
  }
}

#clock.simpleclock {
  color: #89b4fa;
}

#window {
  color: #cdd6f4;
}

#pulseaudio {
  color: #b4befe;
}

#pulseaudio.muted {
  color: #a6adc8;
}

#custom-logo {
  color: #89b4fa;
}

#custom-power {
  color: #f38ba8;
}

tooltip {
  background-color: #181825;
  border: 2px solid #89b4fa;
}
    '';

    settings = [{
      layer = "bottom";
      position = "top";
      height = 40;
      spacing = 2;
      exclusive = true;
      passthrough = false;
      "gtk-layer-shell" = true;
      "fixed-center" = true;
      "modules-left" = [ "hyprland/workspaces" "hyprland/window" ];
      "modules-center" = [ "mpris" ];
      "modules-right" = [
        "cpu"
        "memory"
        "pulseaudio"
        "backlight"
        "battery"
        "clock"
        "clock#simpleclock"
        "tray"
        "custom/notification"
        "custom/power"
      ];

      "custom/spotify" = {
        format = "  {}";
        "return-type" = "json";
      };

      "backlight" = {
        format = " {percent}%";
        "on-click" = "hyprctl dispatch backlight 10+";
        "on-click-right" = "hyprctl dispatch backlight 10-";
      };

      mpris = {
        player = "spotify_player";
        "dynamic-order" = [ "artist" "title" ];
        format = "{player_icon} {dynamic}";
        "format-paused" = "{status_icon} <i>{dynamic}</i>";
        "status-icons" = { paused = ""; };
        "player-icons" = { default = ""; };
        "on-click" = "playerctl -p spotify_player play-pause";
        "on-click-right" = "playerctl -p spotify_player next";
        "on-scroll-up" = "hyprctl dispatch focusworkspaceoncurrentmonitor 9";
        "on-scroll-down" = "hyprctl dispatch focusworkspaceoncurrentmonitor 1";
      };

      "hyprland/workspaces" = {
        "on-click" = "activate";
        "format" = "{icon}";
        "format-icons" = {
          "8" = "";
          "9" = "";
        };
        "all-outputs" = true;
        "disable-scroll" = false;
        "active-only" = false;
      };

      "hyprland/window" = {
        format = "{title}";
      };

      battery = {
        interval = 2;
        states = {
          warning = 25;
          critical = 15;
        };
        format = "{icon}{capacity: >3}%";
        format-charging = " {capacity}%";
        format-plugged = " {capacity}%";
        format-full = " {icon}{capacity}%";
        format-icons = [ "" "" "" "" "" ];
      };

      tray = {
        "show-passive-items" = true;
        spacing = 10;
      };

      "clock#simpleclock" = {
        tooltip = false;
        format = " {:%H:%M}";
      };

      clock = {
        format = " {:L%a %d %b}";
        calendar = {
          format = {
            days = "<span weight='normal'>{}</span>";
            months = "<span color='#cdd6f4'><b>{}</b></span>";
            today = "<span color='#f38ba8' weight='700'><u>{}</u></span>";
            weekdays = "<span color='#f9e2af'><b>{}</b></span>";
            weeks = "<span color='#a6e3a1'><b>W{}</b></span>";
          };
          mode = "month";
          "mode-mon-col" = 1;
          "on-scroll" = 1;
        };
        "tooltip-format" = "<span color='#cdd6f4' font='Lexend 16'><tt><small>{calendar}</small></tt></span>";
      };

      cpu = {
        format = " {usage}%";
        tooltip = true;
        interval = 1;
      };

      memory = {
        format = " {used:0.1f}Gi";
      };

      pulseaudio = {
        format = "{icon} {volume}%";
        "format-muted" = "  muted";
        "format-icons" = {
          headphone = "";
          default = [ " " " " " " ];
        };
        "on-click" = "pavucontrol -t 1";
        "on-click-right" = "pamixer -t";
      };

      "custom/sep" = {
        format = "|";
        tooltip = false;
      };

      "custom/power" = {
        tooltip = false;
        "on-click" = "wlogout -p layer-shell &";
        format = "⏻";
      };

      "custom/notification" = {
        escape = true;
        exec = "swaync-client -swb";
        "exec-if" = "which swaync-client";
        format = "{icon}";
        "format-icons" = {
          none = "󰅺";
          notification = "󰡟";
        };
        "on-click" = "sleep 0.1 && swaync-client -t -sw";
        "return-type" = "json";
        tooltip = false;
      };
    }];
  };
}
