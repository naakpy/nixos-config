{ pkgs, ... }:
{
  networking.networkmanager.enable = true;
  
  environment.systemPackages = [
    pkgs.networkmanagerapplet
  ];

  networking.enableIPv6 = false;
  boot.kernel.sysctl."net.ipv6.conf.wlp2s0.disable_ipv6" = true;
  networking.firewall = {
  enable = true;
  allowedTCPPorts = [ 8000 ];
  allowedUDPPorts = [ 8000 ];
}; 
}
