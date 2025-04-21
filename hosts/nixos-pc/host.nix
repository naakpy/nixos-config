{ config, pkgs, lib, ... }: 

{
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
    ../../nixos/greetd.nix
  ];

  networking.hostName = "nixos-pc";

  boot.initrd.systemd.enable = true;
  boot.initrd.kernelModules = [
    "tpm" "tpm_tis_core" "tpm_tis" "tpm_crb"
  ];
  boot.initrd.luks.devices.root = {
    device = "/dev/nvme1n1p2";
    crypttabExtraOpts = [ "tpm2-device=auto" "tpm2-pcrs=0" ];
  };

  services.greetd.settings.initial_session = {
    user    = "kaan";
    command = "${pkgs.hyprland}/bin/Hyprland";
  };

  services.greetd.restart = false;
}
