{
  imports = [
    ../../nixos/vpn.nix
  ];

  networking.wireguard-home = {
    enable = true;
    clientIP = "10.0.0.3";
    privateKeyPath = "/home/kaan/.config/sops-nix/secrets/wireguard-laptop";
  };

  systemd.services.wg-quick-wg0 = {
    after = [ "user@1000.service" ];
    requires = [ "user@1000.service" ];
  };

  services.openvpn.servers = {
    LabVPN  = {
      config = '' config /root/openvpn/LabVPN.ovpn '';
      autoStart = false;
      updateResolvConf = true;
    };
  };
} 