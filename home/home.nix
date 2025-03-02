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
  
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      text-scaling-factor = 0.8;
    };
  };

  xresources.properties = {
    "Xcursor.size" = 24;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.packages = (with pkgs; [
    #user apps
    vscode
    prismlauncher
    terraform
    kubectl
    k9s
    zulu8
    hashcat
    openvpn
    multivnc
    dbeaver-bin
    easyeffects
    runelite
    lutris
    wine
    librewolf
    vesktop
    qFlipper
    spotify-player
    signal-desktop
    digikam
    spice
    super-slicer-latest
    ghidra

    #reverse
    ida-free

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
    btop

    #misc
    ffmpeg
    pamixer
    appimage-run
    rofi-wayland
    brightnessctl
    iotop
    swww
  ]);

  programs.home-manager.enable = true;

  fonts.fontconfig.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.05";
}
