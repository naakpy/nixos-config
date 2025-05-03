{
  config,
  lib,
  ...
}:
{
  services.syncthing = {
    enable = true;
    user = "syncthing";
    group = "syncthing";
    dataDir = "/var/lib/syncthing";
    configDir = "/etc/syncthing";
  };
}

