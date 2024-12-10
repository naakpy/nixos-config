{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";  # For Hyprland and other packages
    home-manager.url = "github:nix-community/home-manager";  # Home Manager
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";  # Hyprland flake
  };

  outputs = inputs @ { self, nixpkgs, home-manager, hyprland, ... }: {
    nixosConfigurations = let
      makeHost = hostName: {
        system = "x86_64-linux";
        specialArgs = { inherit inputs pkgs; };
        modules = [
          ./hosts/${hostName}/hardware-configuration.nix
          ./modules/system.nix
	  ./configuration.nix

          {
            wayland.windowManager.hyprland = {
              enable = true;
              package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
            };
          }

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

