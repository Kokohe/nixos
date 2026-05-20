{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-avf = {
    url = "github:nix-community/nixos-avf";  # verify the exact repo URL
    inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixos-avf, ... }: {
    nixosConfigurations.yarara = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        nixos-avf.nixosModules.avf
        ./configuration.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.koko = import ./home.nix;
        }
      ];
    };
  };
}
