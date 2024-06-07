{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    stylix.url = "github:danth/stylix";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/default/configuration.nix
        inputs.home-manager.nixosModules.default
      ];
    };
    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/desktop/configuration.nix
        inputs.home-manager.nixosModules.default
      ];
    };
    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs outputs;};
      modules = [
        ./hosts/laptop/configuration.nix
        inputs.home-manager.nixosModules.default
        inputs.stylix.nixosModules.stylix
        ({pkgs, ...}: {
          nixpkgs.overlays = [inputs.rust-overlay.overlays.default];
          environment.systemPackages = [
            (pkgs.rust-bin.stable.latest.default.override {
              extensions = ["rust-src" "rust-analyzer"];
            })
          ];
        })
      ];
    };
    nixosConfigurations.ben-desk-nix = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs outputs;};
      modules = [
        ./hosts/ben-desk-nix/configuration.nix
        inputs.home-manager.nixosModules.default
        inputs.stylix.nixosModules.stylix
        ({pkgs, ...}: {
          nixpkgs.overlays = [inputs.rust-overlay.overlays.default];
          environment.systemPackages = [
            (pkgs.rust-bin.stable.latest.default.override {
              extensions = ["rust-src" "rust-analyzer" "clippy"];
            })
          ];
        })
      ];
    };
    nixosConfigurations.ben-lap-nix = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs outputs;};
      modules = [
        ./hosts/ben-lap-nix/configuration.nix
        inputs.home-manager.nixosModules.default
        inputs.stylix.nixosModules.stylix
        ({pkgs, ...}: {
          nixpkgs.overlays = [inputs.rust-overlay.overlays.default];
          environment.systemPackages = [
            (pkgs.rust-bin.stable.latest.default.override {
              extensions = ["rust-src" "rust-analyzer" "clippy"];
            })
          ];
        })
      ];
    };

    homeManagerModules = import ./homeManagerModules;
  };
}
