{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./greetd.nix
  ];

  networking.enableIPv6 = false;
  boot.kernel.sysctl."net.ipv6.conf.wlp2s0.disable_ipv6" = true;

  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;
  boot.kernelParams = [ "kvm.enable_virt_at_load=0" ];

  users.extraGroups.docker.members = [ "kaan" ];
  users.extraGroups.vboxusers.members = [ "kaan" ];

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      kaan = import ../home/home.nix;
    };
  };

  programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
  hardware.flipperzero.enable = true;
  
  services.tlp.enable = true;
  environment.sessionVariables = {
    "ELECTRON_OZONE_PLATFORM_HINT" = "wayland";
    NIXOS_OZONE_WL = "1";
  };

  services.flatpak.enable = true;
  programs.hyprland.enable = true;
  xdg.portal = {
    enable = true;
  };

  nixpkgs = {
    overlays = [];
    config = {
      allowUnfree = true;
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      experimental-features = "nix-command flakes";
      flake-registry = "";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
    };
    channel.enable = false;

    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  security.pam.services.hyprlock = {};
  
  networking.networkmanager.enable = true;
  environment.systemPackages = [
    pkgs.networkmanagerapplet
  ];
  
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;


  users.users = {
    kaan = {
      initialPassword = "password";
      isNormalUser = true;
      openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH2J9YKlcGlhny06zjSme57qFOGarY/F0X9VvulUPrhm kaan@doyurur.xyz"];
      extraGroups = [ "wheel" "networkmanager" "docker" "vboxusers"];
    };
  };

  time.timeZone = "Europe/Paris";

  fonts.packages = [] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.openssh = {
    enable = false;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
