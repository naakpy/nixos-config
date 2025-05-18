{ config, pkgs, lib, ... }: 

{
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
    (import ../../nixos/boot.nix { inherit pkgs; gfxResolution = "3440x1440"; })
  ];

  networking.hostName = "nixos-pc";
}
