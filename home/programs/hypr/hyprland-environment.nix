{ config, pkgs, ... }:

{
  home = {
    sessionVariables = {
      EDITOR = "kitty";
      BROWSER = "firefox";
      TERMINAL = "kitty";

      # Wayland-specific settings
      CLUTTER_BACKEND = "wayland";
      WLR_RENDERER = "vulkan";
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";

      # High DPI scaling
      GDK_SCALE = "2";  # Ensures proper scaling on Wayland
      GDK_DPI_SCALE = "0.5";  # Adjust DPI for higher resolution displays
      XCURSOR_SIZE = "32";
      XFT_DPI = "144";  # Set DPI for better font rendering in X11 applications

      # Qt application scaling
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";  # Enable automatic scaling in Qt apps
      QT_SCALE_FACTOR = "1";  # Ensures Qt apps don't overscale
      QT_QPA_PLATFORM = "wayland;xcb";  # Prioritize Wayland, fallback to X11
      QT_QPA_PLATFORMTHEME = "qt5ct";  # Use qt5ct for theme management
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";  # Remove window decorations in Qt apps

      # SDL applications (games, some utilities)
      SDL_VIDEODRIVER = "wayland";  # Ensures SDL apps run on Wayland

      # XWayland Compatibility
      XWAYLAND_NO_GLAMOR = "0";  # Keep Glamor enabled for better performance
    };
  };
}

