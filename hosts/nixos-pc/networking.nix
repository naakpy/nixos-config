{ config, lib, pkgs, ... }:

{
  imports = [
    ../../nixos/networking/wireguard-base.nix
  ];

  networking.wireguard-home = {
    enable = true;
    clientIP = "10.0.0.2";
    privateKeyPath = "/home/kaan/.config/sops-nix/secrets/wireguard-pc";
  };

  # The WOL module doesn't actually work atm, define an additional service
  # see https://github.com/NixOS/nixpkgs/issues/91352
  systemd.services.wakeonlan = {
    description = "Reenable wake on lan every boot";
    after = [ "network.target" ];
    serviceConfig = {
      Type = "simple";
      RemainAfterExit = "true";
      ExecStart = "${pkgs.writeShellScript "wakeonlan" ''
        while ! ${pkgs.iproute2}/bin/ip link show enp10s0 | grep -q "state UP"; do
          sleep 1
        done

        ${pkgs.ethtool}/sbin/ethtool -s enp10s0 wol g
      ''}";
    };
    wantedBy = [ "default.target" ];
  };

  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
    settings = {
      sunshine_name = "Kaan-NixOS";
      output_name = 2;
    };
    applications = {
      apps = [
        {
          name = "Launch BigSteam";
          image-path = "steam.png";
        }
      ];
    };
  };

  networking.firewall = {
    enable = true;
  };
} 