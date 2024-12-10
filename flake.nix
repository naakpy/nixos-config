{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ { self, nixpkgs, home-manager, ... }: {
    nixosConfigurations = let
      makeHost = hostName: hardwareConfig: {
        system = "x86_64-linux";
        modules = [
          ./hosts/${hostName}/${hardwareConfig}  # Hardware-specific config
          ./modules/system.nix                  # Shared system-wide config

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = inputs;
            home-manager.users.kaan = import ./home;
          }
        ];
      };
    in {
      nixos-pc = nixpkgs.lib.nixosSystem (makeHost "nixos-pc" "hardware-configuration.nix");
      nixos-laptop = nixpkgs.lib.nixosSystem (makeHost "nixos-laptop" "hardware-configuration.nix");
    };
  };
}

