{ pkgs, ... }:

# remove pkgs

{
  boot.kernelParams = [ "kvm.enable_virt_at_load=0" ]; # kernel 6.12 bug fix virtualbox


  # virtualisation.vmware.host.enable = true;

  
  virtualisation.docker.enable = true;
  virtualisation.docker.daemon.settings = {
    live-restore = false;
  };

  users.extraGroups.docker.members = [ "kaan" ];

  services.udev.packages = [
    pkgs.android-udev-rules
  ];
}
