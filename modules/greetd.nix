{ config, pkgs, lib, ... }:
{
  services.greetd = {
    enable = true;
    settings = {
      greeter = {
        command = "${pkgs.tuigreet}/bin/tuigreet";
        user = "greeter";
      };
    };
  };


  users.users.greeter = {
    isSystemUser = true;
    description = "Greeter User for greetd";
    home = "/var/empty";
    shell = pkgs.busybox;
  };
}

