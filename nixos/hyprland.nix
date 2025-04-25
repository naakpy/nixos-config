{ ... }:
{
  programs.hyprland.enable = true;
  xdg.portal = {
    enable = true;
  };

  security.pam.services.hyprlock = {};


  environment.sessionVariables = {
    "ELECTRON_OZONE_PLATFORM_HINT" = "wayland";
    NIXOS_OZONE_WL = "1";
  };
}
