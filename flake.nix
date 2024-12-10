{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";  # Add Hyprland flake
  };

  outputs = inputs @ { self, nixpkgs, home-manager, hyprland, ... }: {
    nixosConfigurations = let
      makeHost = hostName: {
        system = "x86_64-linux";
        modules = [
          ./hosts/${hostName}/hardware-configuration.nix
          ./modules/system.nix

          {
            wayland.windowManager.hyprland = {
              enable = true;
              package = inputs.hyprland.packages.${nixpkgs.stdenv.hostPlatform.system}.hyprland;
            };
          }

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = inputs;
            home-manager.users.kaan = import ./home;
          }
        ];
      };
    in {
      nixos-pc = nixpkgs.lib.nixosSystem (makeHost "nixos-pc");
      nixos-laptop = nixpkgs.lib.nixosSystem (makeHost "nixos-laptop");
    };
  };
}

