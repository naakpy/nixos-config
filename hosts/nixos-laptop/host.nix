{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
  ];

  networking.hostName = "nixos-laptop";
  boot.kernelParams = [ "amdgpu.dcdebugmask=0x10" ];
}

