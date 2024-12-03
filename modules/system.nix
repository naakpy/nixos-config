{ pkgs, lib, ... }:
{
  imports = [
    ./packages.nix
    ./pipewire.nix
    ./hyprland.nix
    ./fonts.nix
    ./steam.nix
    ./waybar.nix
    ./greetd.nix
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kaan = {
    isNormalUser = true;
    description = "kaan";
    extraGroups = ["networkmanager" "wheel" "vboxusers" "docker"];
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
  };

  # customise /etc/nix/nix.conf declaratively via `nix.settings`
  nix.settings = {
    # enable flakes globally
    experimental-features = ["nix-command" "flakes"];
  };

  # do garbage collection weekly to keep disk usage low
  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 7d";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";


  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable Network manager
  networking.networkmanager.enable = true;
  
  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "client";  

  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.guest.draganddrop = true;

  virtualisation.docker.rootless = {
  enable = true;
  setSocketVariable = true;
  
  };
  programs.hyprland.xwayland.enable = true;

  environment.systemPackages = [
    pkgs.bash
  ];

}
