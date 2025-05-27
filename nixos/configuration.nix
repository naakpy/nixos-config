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
    ./syncthings.nix
    ./boot.nix
    ./xserver.nix
  ];

  programs.fish.enable = true;

  hardware.flipperzero.enable = true;
  services.tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "ondemand";
        CPU_SCALING_GOVERNOR_ON_BAT = "conservative";

        CPU_DRIVER_OPMODE_ON_AC = "passive";
        CPU_DRIVER_OPMODE_ON_BAT = "passive";

        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;

        PLATFORM_PROFILE_ON_AC = "balanced";
        PLATFORM_PROFILE_ON_BAT = "low-power";

        RADEON_DPM_PERF_LEVEL_ON_AC = "auto";
        RADEON_DPM_PERF_LEVEL_ON_BAT = "low";

        START_CHARGE_THRESH_BAT0 = 65;
        STOP_CHARGE_THRESH_BAT0 = 80;
      };
  };
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
      extraGroups = [ "wheel" "networkmanager" "docker" "vboxusers" "disk"];
    };
  };

  time.timeZone = "Europe/Paris";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
