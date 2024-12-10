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
      makeHost = hostName: {
        system = "x86_64-linux";
        specialArgs = { inherit inputs pkgs; };  # Pass both inputs and pkgs to modules
        modules = [
          ./hosts/${hostName}/hardware-configuration.nix
          ./modules/system.nix
          ./configuration.nix
          
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

