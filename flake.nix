{
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Additional inputs
    cursor.url = "github:omarcresp/cursor-flake/main";
  };

  outputs = { self, nixpkgs, home-manager, cursor, ... } @ inputs: let
    inherit (self) outputs;
  in {
    nixosConfigurations = {
      nixos-pc = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [
          ./nixos/configuration.nix
          ./hosts/nixos-pc/host.nix
          ./hosts/nixos-pc/hardware-configuration.nix
          ({ pkgs, ... }: {
            environment.systemPackages = [ cursor.packages.${pkgs.system}.default ];
          })
        ];
      };

      nixos-laptop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [
          ./nixos/configuration.nix
          ./hosts/nixos-laptop/host.nix
          ./hosts/nixos-laptop/hardware-configuration.nix
          ({ pkgs, ... }: {
            environment.systemPackages = [ cursor.packages.${pkgs.system}.default ];
          })
        ];
      };
    };
  };
}

