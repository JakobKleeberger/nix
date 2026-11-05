{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    # nixvim.url = "github:nix-community/nixvim";
    nvim.url = "github:jakobkleeberger/nixvim";
    stylix.url = "github:danth/stylix";
    # sops-nix.url = "github:Mic92/sops-nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      ...
    }@inputs:
    let
      # Gemeinsame Nixpkgs-Konfiguration für alle Hosts
      sharedNixpkgsConfig = {
        nixpkgs.config = {
          allowUnfree = true;
          allowBroken = true;
          problems.handlers = {
            "gtk+".broken = "ignore"; # oder "warn"
          };
        };
      };
    in
    {
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          sharedNixpkgsConfig
          ./hosts/default/configuration.nix
          inputs.home-manager.nixosModules.default
          inputs.stylix.nixosModules.stylix
          # inputs.sops-nix.nixosModules.sops
        ];
      };
      nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          sharedNixpkgsConfig
          ./hosts/desktop/configuration.nix
          inputs.home-manager.nixosModules.default
          inputs.stylix.nixosModules.stylix
          # inputs.sops-nix.nixosModules.sops
        ];
      };
      nixosConfigurations.work = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          sharedNixpkgsConfig
          ./hosts/work/configuration.nix
          inputs.home-manager.nixosModules.default
          inputs.stylix.nixosModules.stylix
          # inputs.sops-nix.nixosModules.sops
        ];
      };
      nixosConfigurations.homelab = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          sharedNixpkgsConfig
          ./hosts/homelab/configuration.nix
          inputs.home-manager.nixosModules.default
          # inputs.sops-nix.nixosModules.sops
        ];
      };
      nixosConfigurations.nas = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          sharedNixpkgsConfig
          ./hosts/nas/configuration.nix
          inputs.home-manager.nixosModules.default
          # inputs.sops-nix.nixosModules.sops
        ];
      };
    };
}
