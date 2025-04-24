{ config, pkgs, lib, ... }: 

{
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
    ../../nixos/greetd.nix
  ];

  networking.hostName = "nixos-pc";

  services.greetd.settings.initial_session = {
    user    = "kaan";
    command = "${pkgs.hyprland}/bin/Hyprland";
  };

  services.greetd.restart = false;
}
