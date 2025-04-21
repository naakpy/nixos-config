{ config, pkgs, ... }:

let
  tuigreet      = "${pkgs.greetd.tuigreet}/bin/tuigreet";
  hyprland_sess = "${pkgs.hyprland}/share/wayland-sessions";
in {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        user    = "greeter";
        command = ''
          ${tuigreet}
          --time
          --remember
          --remember-session
          --sessions ${hyprland_sess}
        '';
      };
    };
  };

  systemd.services.greetd.serviceConfig = {
    Type             = "idle";
    StandardInput    = "tty";
    StandardOutput   = "tty";
    StandardError    = "journal";
    TTYReset         = true;
    TTYVHangup       = true;
    TTYVTDisallocate = true;
  };
}
