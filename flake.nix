{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";  
    home-manager.url = "github:nix-community/home-manager";  # Home Manager
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";  # Hyprland flake
  };

  outputs = inputs @ { self, nixpkgs, home-manager, hyprland, ... }: {
    nixosConfigurations = let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;  # Define pkgs explicitly
      lib = pkgs.lib;  # Define lib explicitly

      makeHost = hostName: {
        system = "x86_64-linux";
        specialArgs = { inherit inputs pkgs lib; };  # Pass both inputs, pkgs, and lib to modules
        modules = [
          ./hosts/${hostName}/hardware-configuration.nix
          ./hyprland.nix
          ./modules/packages.nix
          ./modules/waybar.nix
          ./modules/fonts.nix
          ./modules/pipewire.nix
          ./modules/greetd.nix
          {
            networking.hostName = hostName; # Dynamically set the hostname
            users.users.kaan = {
              isNormalUser = true;
              description = "kaan";
              extraGroups = ["networkmanager" "wheel" "vboxusers" "docker"];
              shell = pkgs.zsh;
              ignoreShellProgramCheck = true;
            };

            nix.settings = {
              experimental-features = ["nix-command" "flakes"];
            };

            nix.gc = {
              automatic = lib.mkDefault true;
              dates = lib.mkDefault "weekly";
              options = lib.mkDefault "--delete-older-than 7d";
            };

            nixpkgs.config.allowUnfree = true;

            time.timeZone = "Europe/Paris";

            hardware.bluetooth.enable = true;
            hardware.bluetooth.powerOnBoot = true;

            boot.loader.systemd-boot.enable = true;
            boot.loader.efi.canTouchEfiVariables = true;

            system.stateVersion = "24.05";

            services.printing.enable = true;
            networking.networkmanager.enable = true;

            services.tailscale.enable = true;
            services.tailscale.useRoutingFeatures = "client";

            virtualisation.virtualbox.host.enable = true;

            virtualisation.docker.rootless = {
              enable = true;
              setSocketVariable = true;
            };
          }

          # Home Manager configuration
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = inputs;  # Provide inputs to Home Manager
            home-manager.users.kaan = import ./home;  # User-specific Home Manager config
          }
        ];
      };
    in {
      nixos-pc = nixpkgs.lib.nixosSystem (makeHost "nixos-pc");
      nixos-laptop = nixpkgs.lib.nixosSystem (makeHost "nixos-laptop");
    };
  };
}

