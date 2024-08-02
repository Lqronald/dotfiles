{
  description = "PlasmaNix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #nixpkgsstable.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {nixpkgs, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
    host = "plasmaNix";
    username = "ronald";
  in {
    nixosConfigurations = {
      "${host}" = nixpkgs.lib.nixosSystem {
        specialArgs = {
              inherit system;
              inherit inputs;
              inherit username;
              inherit host;
            };
        modules = [
          ./config/configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager.extraSpecialArgs = {
              inherit username;
              inherit inputs;
              inherit host;
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users."${username}" = import ./config/home.nix;
          }
        ];
      };
    };
  };
}
