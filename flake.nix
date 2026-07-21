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
    nixos-06cb-009a-fingerprint-sensor.url = "github:ahbnr/nixos-06cb-009a-fingerprint-sensor?ref=24.11";
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ ... }: let
      vars = import ./vars.nix;
    in {
      nixosConfigurations = {
        t480 = inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs vars ; };
          modules = [
            inputs.stylix.nixosModules.stylix
            inputs.nixvim.nixosModules.nixvim
            inputs.nixos-06cb-009a-fingerprint-sensor.nixosModules."06cb-009a-fingerprint-sensor"
            inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480
            inputs.home-manager.nixosModules.home-manager
            ./modules/nixvim/default.nix
            ./hosts/t480/configuration.nix
            inputs.sops-nix.nixosModules.sops
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
