{
  imports = [
    ../../nixos/vpn.nix
  ];

  networking.wireguard-home = {
    enable = true;
    clientIP = "10.0.0.3";
    privateKeyPath = "/home/kaan/.config/sops-nix/secrets/wireguard-laptop";
  };

  services.openvpn.servers = {
    LabVPN  = {
      config = '' config /root/openvpn/LabVPN.ovpn '';
      autoStart = false;
      updateResolvConf = true;
    };
  };
} 