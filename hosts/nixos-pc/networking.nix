{
  imports = [
    ../../nixos/networking/wireguard-base.nix
  ];

  networking.wireguard-home = {
    enable = true;
    clientIP = "10.0.0.3";
  };
} 