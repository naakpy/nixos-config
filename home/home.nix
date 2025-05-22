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
    inputs.sops-nix.homeManagerModules.sops
  ];

  nixpkgs = {
    overlays = [];
    config = {
      allowUnfree = true;
    };
  };

  sops = {
    age.keyFile = "/home/kaan/.config/sops/age/keys.txt";
    defaultSopsFile = ../secrets.yaml;
    defaultSopsFormat = "yaml";
    secrets = {
      wireguard-pc = {
        path = "%r/wireguard-pc";
      };
      wireguard-laptop = {
        path = "%r/wireguard-laptop";
      };
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

    ssh-to-age
    xorg.xrdb
    thunderbird 
    age
    sops
    hyprcursor
    # Development Tools
    vscode
    android-tools
    android-udev-rules
    nasm
    exegol
    upower
    jellyfin-media-player
    logseq
    vlc
    kdePackages.kdenlive
    bluez
    code-cursor
    minikube
    p7zip
    nmap
    joplin-desktop
    kubernetes-helm
    gnome-keyring
    talosctl
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
    ethtool

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

    feh
    nemo

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
