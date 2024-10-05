{
  description = "A derui's NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.ereshkigal = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        # import root configuration
        ./configuration.nix
        # system modules
        ./modules/hyprland.nix
        ./modules/fcitx.nix
        ./modules/gpu.nix
        ./modules/bluetooth.nix
        ./modules/steam.nix

        # home-manager support
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.derui = import ./home.nix;
        }
      ];
    };
  };
}
