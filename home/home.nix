{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./programs
    ./scripts
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
    spotify-player

    #utils
    ranger
    wget
    curl
    pavucontrol
    tree

    #misc
    appimage-run
    cava
    pamixer
    btop
    iotop
    tokyo-night-gtk
    swww
  ]);

  programs.home-manager.enable = true;

  fonts.fontconfig.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.05";
}
