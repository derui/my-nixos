{
  description = "A derui's NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.ereshkigal = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # import root configuration
        ./configuration.nix
      ];
    };
  };
}
