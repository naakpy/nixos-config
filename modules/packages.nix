{ pkgs, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    (callPackage ./custom/cursor.nix {})
    exegol
    prismlauncher
    dbeaver-bin
    easyeffects
    burpsuite
    obsidian
    nano
    vim
    wget
    curl
    openssl
    git
    sysstat
    lm_sensors
    neofetch
    xfce.thunar
    ranger
    pavucontrol
    librewolf
    btop
    iotop
    iftop
    kitty
    rofi-wayland
    freetube
    steam
    cmake
    gnumake
    libgcc
    gcc
    xorg.xrandr
    nodejs
    yarn
    zsh
    unzip
    python3
    appimage-run
    criterion
    swww
    networkmanagerapplet
    mako
    jq
    brightnessctl
    hyprshot
    nomacs
    firefox
    rpi-imager
    webcord
  ];
}
