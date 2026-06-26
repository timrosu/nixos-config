{
  description = "flandr unified nix env";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim.url = "github:nix-community/nixvim/nixos-26.05";
  };

  outputs =
    inputs@{ nixpkgs, home-manager, nixvim, ... }: let
      vars = import ./vars.nix;
    in {
      nixosConfigurations = {
        t480 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/t480/configuration.nix
	    nixvim.nixosModules.nixvim
	    ./modules/nixvim.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.${vars.username} = ./home.nix;
            }
          ];
        };
      };
    };
}
