{ config, pkgs, ... }:

{
  imports = [
    ../../modules/system.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "nixos-laptop";
  boot.kernelParams = [ "amdgpu.dcdebugmask=0x10" ];
}

