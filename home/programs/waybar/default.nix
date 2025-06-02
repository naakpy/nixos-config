{ config, lib, pkgs, ... }:

{
  programs.waybar = {
    enable = true;

    style = ''
      @define-color background #35130d;
      @define-color foreground #fbe699;
      @define-color accent     #d44f0a;
      @define-color secondary  #fb9f3b;
      @define-color surface    #231c14;
      @define-color muted      #845c40;
      @define-color border     #631a0a;

      * {
        font-family: JetBrains Mono, monospace;
        font-size: 14px;
        background: @background;
        color: @foreground;
      }

      #battery.charging {
        color: @accent;
      }
      #battery.critical {
        color: @secondary;
      }

      window#waybar {
        padding: 0;
        margin: 0;
      }
    '';

    settings = [{
      modules-left = [
        "custom/launcher"
        "custom/separator"
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
        "custom/separator"
        "clock"
      ];

      /* Module Configurations */
      "battery" = {
        format = "󰁹 {capacity}%";
        format-charging = "󰂄 {capacity}%";
        interval = 30;
        states = {
          critical = 10;
          urgent = 5;
          warning = 30;
        };
      };

      "clock" = {
        format = "{:%I:%M:%S %p  %A %b %d}";
        interval = 1;
        tooltip = true;
        tooltip-format = "{:%A; %d %B %Y}\n<tt>{calendar}</tt>";
      };

      "custom/launcher" = {
        format = " λ";
        "on-click" = "pkill rofi || rofi -show drun";
        tooltip = false;
      };

      "custom/separator" = {
        format = " │ ";
        tooltip = false;
      };

      "hyprland/workspaces" = {
        "format" = "{icon}";
        "separate-outputs" = true;
        "format-icons" = {
          "active" = "󱎴";
          "default" = "󰍹";
        };
        "on-click" = "activate";
      };

      "pulseaudio" = {
        format = "{icon} {volume}%";
        format-icons.default = [ "" "" "" ];
        format-muted = "󰖁 Muted";
        "on-click" = "pkill pavucontrol || pavucontrol";
        "on-click-right" = "pamixer -t";
        scroll-step = 1;
        tooltip = false;
      };

      "tray" = {
        reverse-direction = true;
      };

      "backlight" = {
        format = "{icon} {percent}%";
        format-icons = [ "󰃞" "󰃝" "󰃟" "󰃞" ];
        tooltip = false;
      };
    }];
  };
}
