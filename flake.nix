{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";  
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = inputs @ { self, nixpkgs, home-manager, hyprland, ... }: let
    # Define the function in the correct scope
    makeNixosSystem = hostName: inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/${hostName}/hardware-configuration.nix
        ./hyprland.nix
        ./modules/packages.nix
        ./modules/waybar.nix
        ./modules/fonts.nix
        ./modules/pipewire.nix
        ./modules/greetd.nix
        {
          # Host-specific settings
          networking.hostName = hostName;
          users.users.kaan = {
            isNormalUser = true;
            description = "Kaan";
            extraGroups = ["networkmanager" "wheel" "vboxusers" "docker"];
            shell = inputs.nixpkgs.legacyPackages.x86_64-linux.zsh;
            ignoreShellProgramCheck = true;
          };

          nix.settings.experimental-features = ["nix-command" "flakes"];
          nix.gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 7d";
          };

          nixpkgs.config.allowUnfree = true;
          time.timeZone = "Europe/Paris";

          hardware.bluetooth = {
            enable = true;
            powerOnBoot = true;
          };

          boot.loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
          };

          system.stateVersion = "24.05";

          networking.networkmanager.enable = true; # Corrected NetworkManager option
          
          services.tailscale = {
            enable = true;
            useRoutingFeatures = "client";
          };

          virtualisation = {
            virtualbox.host.enable = true;
            docker.rootless = {
              enable = true;
              setSocketVariable = true;
            };
          };

          services.printing.enable = true; # Kept printing under services
        }

        # Home Manager module for user-specific configurations
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = inputs; # Pass inputs to Home Manager
          home-manager.users.kaan = import ./home; # Link Home Manager configuration
        }
      ];
    };
  in {
    nixosConfigurations = {
      # Dynamically create configurations for each host
      nixos-pc = makeNixosSystem "nixos-pc";
      nixos-laptop = makeNixosSystem "nixos-laptop";
    };
  };
}

