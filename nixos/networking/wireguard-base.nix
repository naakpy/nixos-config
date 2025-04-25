{
  config,
  lib,
  ...
}: {
  options = {
    networking.wireguard-home = {
      enable = lib.mkEnableOption "Enable home Wireguard configuration";
      clientIP = lib.mkOption {
        type = lib.types.str;
        description = "The IP address for this Wireguard client";
      };
      privateKeyPath = lib.mkOption {
        type = lib.types.str;
        description = "Path to the SOPS-managed private key file";
      };
    };
  };

  config = lib.mkIf config.networking.wireguard-home.enable {
    networking.wg-quick.interfaces = {
      wg0 = {
        address = [ "${config.networking.wireguard-home.clientIP}/24" ];
        dns = [ "192.168.1.121" ];
        privateKeyFile = config.networking.wireguard-home.privateKeyPath;

        peers = [
          {
            publicKey = "jEXcaYPTsO4qYPhII3mKN3djTiXxlcYS0fyF/fu6yTI=";
            allowedIPs = [ "0.0.0.0/0" ];
            endpoint = "vpn.doyurur.xyz:51820";
            persistentKeepalive = 25;
          }
        ];
        postUp = "iptables -t nat -A POSTROUTING -o wg0 -j MASQUERADE";
        preDown = "iptables -t nat -D POSTROUTING -o wg0 -j MASQUERADE";
      };
    };
  };
} 
