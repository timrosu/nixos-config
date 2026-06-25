{
  description = "flandr unified nix env";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixvim.url = "github:nix-community/nixvim/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    yazi.url = "github:sxyazi/yazi";
  };
  outputs = { self, nixpkgs, nixvim, nur, home-manager, yazi, ... }@inputs: let
    vars = import ./vars.nix;
  in {
    nixosConfigurations = {
      t480 = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/t480/configuration.nix
          nixvim.nixosModules.nixvim
          ./modules/nixvim.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${vars.username} = ./home-manager/users/${vars.username}.nix;
            home-manager.extraSpecialArgs = { inherit inputs vars; hostName = "t480"; };
          }
        ];
      }
    };
  };
}
