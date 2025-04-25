{ config, pkgs, lib, ... }: 

{
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
  ];

  networking.hostName = "nixos-pc";
}
