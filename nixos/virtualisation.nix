{ pkgs, ... }:

# remove pkgs

{
  boot.kernelParams = [ "kvm.enable_virt_at_load=0" ]; # kernel 6.12 bug fix virtualbox

  #virtualisation.virtualbox.host.enable = true;
  #virtualisation.virtualbox.host.enableExtensionPack = true;

  virtualisation.vmware.host.enable = true;
  
  virtualisation.docker.enable = true;
  virtualisation.docker.daemon.settings = {
    live-restore = false;
  };

  users.extraGroups.docker.members = [ "kaan" ];
  users.extraGroups.vboxusers.members = [ "kaan" ];

  services.udev.packages = [
    pkgs.android-udev-rules
  ];
}
