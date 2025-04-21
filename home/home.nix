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
  
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.packages = (with pkgs; [
    # Development Tools
    vscode
    bluez
    code-cursor
    go
    zulu8
    dbeaver-bin
    terraform
    ansible

    # Kubernetes & Cloud Tools
    kubernetes-helm
    kubectl
    k9s
    talosctl

    # Security & VPN
    gnome-keyring
    openvpn
    hashcat
    nmap
    tcpdump

    # Gaming & Entertainment
    prismlauncher
    runelite
    lutris
    wine
    vesktop
    spotify-player
    signal-desktop

    # Audio & Video Tools
    noisetorch
    easyeffects
    ffmpeg
    pamixer
    pavucontrol

    # System Utilities
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
    tree
    hyprshot
    btop
    iotop
    p7zip
    brightnessctl

    # Desktop Environment
    rofi-wayland
    swww

    # Reverse Engineering & Analysis
    ghidra
    ida-free

    # Miscellaneous
    joplin-desktop
    multivnc
    qFlipper
    spice
    nix-prefetch
    super-slicer-latest
    appimage-run
  ]);

  programs.home-manager.enable = true;

  fonts.fontconfig.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.05";
}
