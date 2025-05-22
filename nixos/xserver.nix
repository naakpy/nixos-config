{
  config,
  pkgs,
  lib,
  ...
}: {
  services.xserver = {
    enable = true;
    dpi = 96;
  };
  
  # Font configuration as a separate service
  fonts.fontconfig = {
    enable = true;
    antialias = true;
    hinting = {
      enable = true;
      style = "full";
    };
    subpixel = {
      lcdfilter = "default";
      rgba = "rgb";
    };
  };
}
