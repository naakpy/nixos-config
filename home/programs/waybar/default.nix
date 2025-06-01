{ config, lib, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = false;
      target = "graphical-session.target";
    };
    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 12pt;
        font-weight: bold;
        border-radius: 8px;
        transition-property: background-color;
        transition-duration: 0.5s;
      }
      @keyframes blink_red {
        to {
          background-color: rgb(242, 143, 173);
          color: rgb(26, 24, 38);
        }
      }
      .urgent {
        animation-name: blink_red;
        animation-duration: 1s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }
      window#waybar {
        background-color: transparent;
      }
      window > box {
        margin-left: 5px;
        margin-right: 5px;
        margin-top: 5px;
        background-color: #1e1e2a;
        padding: 3px;
        padding-left: 8px;
        border: 2px none #33ccff;
      }
      tooltip {
        background: rgb(48, 45, 65);
      }
      tooltip label {
        color: rgb(217, 224, 238);
      }
      #custom-launcher {
        font-size: 20px;
        padding-left: 8px;
        padding-right: 6px;
        color: #7ebae4;
      }
      #mode, #clock, #memory, #temperature, #cpu, #custom-wall, #temperature, #backlight, #pulseaudio, #network, #battery, #custom-powermenu, #custom-separator {
        padding-left: 10px;
        padding-right: 10px;
      }
      #memory {
        color: rgb(181, 232, 224);
      }
      #cpu {
        color: rgb(245, 194, 231);
      }
      #clock {
        color: rgb(217, 224, 238);
      }
      #custom-wall {
        color: #33ccff;
      }
      #temperature {
        color: rgb(150, 205, 251);
      }
      #backlight {
        color: rgb(248, 189, 150);
      }
      #pulseaudio {
        color: rgb(245, 224, 220);
      }
      #network {
        color: #ABE9B3;
      }
      #network.disconnected {
        color: rgb(255, 255, 255);
      }
      #custom-powermenu {
        color: rgb(242, 143, 173);
        padding-right: 8px;
      }
      #tray {
        padding-right: 8px;
        padding-left: 10px;
      }
      #battery {
        color: rgb(144, 238, 144);
      }
      #battery.warning {
        color: rgb(255, 223, 0);
      }
      #battery.critical {
        color: rgb(255, 69, 58);
      }
      #battery.urgent {
        animation-name: blink_red;
        animation-duration: 1s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }
      #workspaces button {
        padding: 0 12px;
        background: transparent;
        color: #7aa2f7;
        border-radius: 4px;
      }
      #workspaces button.active {
        background: #7aa2f7;
        color: #1a1b26;
        box-shadow: inset 0 -3px #ffffff;
      }
      #workspaces button.urgent {
        background: #f7768e;
        color: #1a1b26;
      }
      #custom-separator {
        color: rgba(100, 100, 100, 0.4);
        padding-left: 10px;
        padding-right: 10px;
      }
    '';
    settings = [{
      "layer" = "top";
      "position" = "top";
      modules-left = [
        "custom/launcher"
        "temperature"
      ];
      modules-center = [
        "hyprland/workspaces"
      ];
      modules-right = [
        "tray"
        "custom/separator"
        "pulseaudio"
        "backlight"
        "cpu"
        "battery"
        "custom/separator"
        "clock"
      ];
      "custom/launcher" = {
        "format" = "λ";
        "on-click" = "pkill rofi || rofi -show drun";
        "tooltip" = false;
      };
      "hyprland/workspaces" = {
        "format" = "{icon}";
        "on-click" = "activate";
        "all-outputs" = true;
        "format-icons" = {
          "active" = "☢️";
          "default" = "🟧";
          "empty" = "🕳️";
        };
        "sort-by" = "number";
        "persistent-workspaces" = {
          "*" = 3;
        };
      };
      "pulseaudio" = {
        "scroll-step" = 1;
        "format" = "{icon} {volume}%";
        "format-muted" = "󰖁 Muted";
        "format-icons" = {
          "default" = [ "" "" "" ];
        };
        "on-click" = "pkill pavucontrol || pavucontrol";
        "on-click-right" = "pamixer -t";
        "tooltip" = false;
      };
      "clock" = {
        "interval" = 1;
        "format" = "{:%I:%M %p  %A %b %d}";
        "tooltip" = true;
        "tooltip-format" = "{:%A; %d %B %Y}\n<tt>{calendar}</tt>";
      };
      "memory" = {
        "interval" = 1;
        "format" = "󰻠 {percentage}%";
        "states" = {
          "warning" = 85;
        };
      };
      "cpu" = {
        "interval" = 1;
        "format" = "󰍛 {usage}%";
      };
      "network" = {
        "format-disconnected" = "󰯡 Disconnected";
        "format-ethernet" = "󰒢 Connected!";
        "format-linked" = "󰖪 {essid} (No IP)";
        "format-wifi" = "󰖩 {essid}";
        "interval" = 1;
        "tooltip" = false;
      };
      "battery" = {
        "interval" = 30;
        "format" = "󰁹 {capacity}%";
        "format-charging" = "󰂄 {capacity}%";
        "states" = {
          "warning" = 30;
          "critical" = 10;
          "urgent" = 5;
        };
      };
      "custom/powermenu" = {
        "format" = "";
        "on-click" = "pkill rofi || rofi-power-menu";
        "tooltip" = false;
      };
      "tray" = {
        "icon-size" = 25;
        "spacing" = 10;
        "reverse-direction" = true;
      };
      "custom/separator" = {
        "format" = "│";
        "tooltip" = false;
      };
    }];
  };
}
