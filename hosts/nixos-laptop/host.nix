{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./vpn.nix
  ];

  networking.hostName = "nixos-laptop";
  boot.kernelParams = [ "amdgpu.dcdebugmask=0x10" ];
}

