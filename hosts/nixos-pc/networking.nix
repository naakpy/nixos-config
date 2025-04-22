{
  imports = [
    ../../nixos/networking/wireguard-base.nix
  ];

  networking.wireguard-home = {
    enable = true;
    clientIP = "10.0.0.3";
  };

  networking.interfaces.enp10s0.wakeOnLan.enable = true;

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
  allowedTCPPorts = [ 4242 ];
  };
} 