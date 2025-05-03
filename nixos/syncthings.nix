{
  config,
  lib,
  ...
}:
{
  services.syncthing = {
    enable = true;
    user = "kaan";
    group = "kaan";
    dataDir = "/home/kaan/syncthing";
    configDir = "/home/kaan/.config/syncthing";
  };
}

