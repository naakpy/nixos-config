# cron.nix
{ pkgs, ... }:

{
  systemd.timers = {
    updateCursor = {
      description = "Update Cursor AppImage daily";
      wantedBy = [ "timers.target" ];
      timerConfig.OnCalendar = "daily";
    };
  };

  systemd.services = {
    updateCursor = {
      description = "Run update-cursor.sh to update Cursor AppImage";
      serviceConfig.User = "kaan";
      # Now pkgs is passed explicitly, so this will work
      serviceConfig.ExecStart = "${pkgs.bash}/bin/bash ~/nixos-config/modules/custom/cursor/update-cursor.sh";
      serviceConfig.Type = "oneshot";
    };
  };
}

