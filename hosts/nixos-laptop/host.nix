{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./vpn.nix
    (import ../../nixos/boot.nix { inherit pkgs; gfxResolution = "2880x1800"; })
  ];

  networking.hostName = "nixos-laptop";
  boot.kernelParams = [ "amdgpu.dcdebugmask=0x10" ];
}

