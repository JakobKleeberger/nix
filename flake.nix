{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
    stylix.url = "github:danth/stylix";
    # sops-nix.url = "github:Mic92/sops-nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , ...
    } @ inputs: {
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/default/configuration.nix
          inputs.home-manager.nixosModules.default
          inputs.stylix.nixosModules.stylix
          # inputs.sops-nix.nixosModules.sops
        ];
      };
      nixosConfigurations.work = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/work/configuration.nix
          inputs.home-manager.nixosModules.default
          inputs.stylix.nixosModules.stylix
          # inputs.sops-nix.nixosModules.sops
        ];
      };
      nixosConfigurations.homelab = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/homelab/configuration.nix
          inputs.home-manager.nixosModules.default
          # inputs.stylix.nixosModules.stylix
          # inputs.sops-nix.nixosModules.sops
        ];
      };
      nixosConfigurations.nas = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/nas/configuration.nix
          inputs.home-manager.nixosModules.default
          # inputs.stylix.nixosModules.stylix
          # inputs.sops-nix.nixosModules.sops
        ];
      };
    };
}
