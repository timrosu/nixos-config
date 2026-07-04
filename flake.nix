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
    nixos-06cb-009a-fingerprint-sensor = {
      url = "github:ahbnr/nixos-06cb-009a-fingerprint-sensor?ref=24.11";
    };
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { 
    self,
    nixpkgs,
    home-manager,
    nixvim,
    yazi,
    nixos-06cb-009a-fingerprint-sensor,
    nixos-hardware,
    stylix,
    ...
  }@inputs: let
      vars = import ./vars.nix;
    in {
      nixosConfigurations = {
        t480 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
	  specialArgs = { inherit inputs vars self; };
          modules = [
	    stylix.nixosModules.stylix
            ./hosts/t480/configuration.nix
	    nixvim.nixosModules.nixvim
	    ./modules/nixvim/default.nix
	    nixos-06cb-009a-fingerprint-sensor.nixosModules."06cb-009a-fingerprint-sensor"
	    nixos-hardware.nixosModules.lenovo-thinkpad-t480
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
