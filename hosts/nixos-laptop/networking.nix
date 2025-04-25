{
  imports = [
    ../../nixos/networking/wireguard-base.nix
  ];

  networking.wireguard-home = {
    enable = true;
    clientIP = "10.0.0.2";
    privateKeyPath = "/home/kaan/.config/sops-nix/secrets/wireguard-laptop";
  };

  networking.firewall = {
    allowedTCPPorts = [ 4242 ];
    allowedUDPPorts = [ 4242 ];
  };

  services.openvpn.servers = {
    LabVPN  = {
      config = '' config /root/openvpn/LabVPN.ovpn '';
      autoStart = false;
      updateResolvConf = true;
    };
  };
} 