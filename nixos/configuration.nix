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
    ./virtualisation.nix
    ./steam.nix
    ./bluetooth.nix
    ./fonts.nix
    ./audio.nix
    ./hyprland.nix
    ./networking.nix
  ];

  hardware.flipperzero.enable = true;
  services.tlp.enable = true;
  services.flatpak.enable = true;

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      kaan = import ../home/home.nix;
    };
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
    };
    channel.enable = false;

    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  
  users.users = {
    kaan = {
      initialPassword = "password";
      isNormalUser = true;
      openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH2J9YKlcGlhny06zjSme57qFOGarY/F0X9VvulUPrhm kaan@doyurur.xyz"];
      extraGroups = [ "wheel" "networkmanager" "docker" "vboxusers"];
    };
  };

  time.timeZone = "Europe/Paris";




  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
