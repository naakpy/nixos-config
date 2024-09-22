{ pkgs, ... }:
{
  # Place the script into /etc where it can be easily referenced by systemd
  environment.etc."update-cursor.sh".source = ./custom/cursor/update-cursor.sh;

  systemd.timers = {
    updateCursor = {
      description = "Update Cursor AppImage daily";
      wantedBy = [ "timers.target" ];
      # Run daily at midnight and persist missed runs
      timerConfig.OnCalendar = "daily";
      timerConfig.Persistent = true;
    };
  };

  systemd.services = {
    updateCursor = {
      description = "Run update-cursor.sh to update Cursor AppImage";
      serviceConfig.User = "kaan";
      # Reference the script from /etc
      serviceConfig.ExecStart = "${pkgs.bash}/bin/bash /etc/update-cursor.sh";
      serviceConfig.Type = "oneshot";
      # Ensure the necessary binaries are available
      path = [ pkgs.nix pkgs.bash ];
    };
  };
}

