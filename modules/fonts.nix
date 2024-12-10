{ pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      # Icon fonts
      material-design-icons

      # Normal fonts
      noto-fonts
      noto-fonts-emoji
      noto-fonts-cjk-sans
      font-awesome

      # Nerd fonts
      nerd-fonts.fira_code
      nerd-fonts.jetbrains_mono
    ];

    # Use fonts specified by user rather than default ones
    enableDefaultPackages = false;

    # User-defined fonts
    # The reason there's Noto Color Emoji everywhere is to override DejaVu's
    # B&W emojis that would sometimes show instead of some Color emojis
    fontconfig.defaultFonts = {
      serif = ["Noto Serif" "Noto Color Emoji"];
      sansSerif = ["Noto Sans" "Noto Color Emoji"];
      monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
      emoji = ["Noto Color Emoji"];
    };
  };
}

