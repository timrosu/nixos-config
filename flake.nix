{
  description = "flandr unified nix env";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixvim.url = "github:nix-community/nixvim/nixos-26.05";
    yazi.url = "github:sxyazi/yazi";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixvim, yazi, ... }@inputs: let
      vars = import ./vars.nix;
    in {
      nixosConfigurations = {
        t480 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
	  specialArgs = { inherit inputs vars self; };
          modules = [
            ./hosts/t480/configuration.nix
	    nixvim.nixosModules.nixvim
	    ./modules/nixvim.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs vars; hostName = "t480"; };
              home-manager.users.${vars.username} = ./home/home.nix;
            }
          ];
        };
      };
    };
}
