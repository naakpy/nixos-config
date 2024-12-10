{ config, pkgs, ... }:

{
  imports = [
    ../../modules/system.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "nixos-pc";
}

