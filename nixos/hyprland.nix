{ pkgs, ... }:
{
  programs.hyprland.enable = true;
  xdg.portal = {
    xdgOpenUsePortal = true;
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  services.dbus.enable = true;

  security.pam.services.hyprlock = {};

  environment.sessionVariables = {
    "ELECTRON_OZONE_PLATFORM_HINT" = "wayland";
    NIXOS_OZONE_WL = "1";
  };
}
