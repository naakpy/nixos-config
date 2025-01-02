{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./programs
    ./themes
  ];

  nixpkgs = {
    overlays = [];
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "kaan";
    homeDirectory = "/home/kaan";
  };

  home.packages = (with pkgs; [
    #user apps
    vscode
    firefox
    vesktop
    qFlipper
    spotify-player
    signal-desktop
    digikam
    spice
    jellyfin-media-player
    super-slicer-latest
    jellyfin-media-player

    #utils
    ranger
    dnsutils
    qemu
    powertop
    quickemu
    unzip
    virt-viewer
    jq
    wget
    curl
    pavucontrol
    tree
    hyprshot
    openvpn
    btop
    ffmpeg

    #misc
    python3
    openssl
    ffmpeg
    pamixer
    appimage-run
    rofi-wayland
    brightnessctl
    iotop
    tokyo-night-gtk
    swww
  ]);

  programs.home-manager.enable = true;

  fonts.fontconfig.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.05";
}
