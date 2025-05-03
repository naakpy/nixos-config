{
  config,
  lib,
  ...
}:
{
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    dataDir = "/home/kaan/Documents/syncthing";
    configDir = "/home/kaan/.config/syncthing";
    user = "kaan";
    group = "users";
    guiAddress = "0.0.0.0:8384";
  };
}

