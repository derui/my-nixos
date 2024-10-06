{
  description = "A derui's NixOS flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Emacs Head
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland
    hyprland.url = "github:hyprwm/Hyprland?submodules=1";

    # NixOS hardware configurations
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs = { self, nixpkgs, home-manager, emacs-overlay, ... }@inputs:
    let
      overlays = [
        (import emacs-overlay)
      ];

      # System types to support.
      supportedSystems = [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];

      # Helper function to generate an attrset '{ x86_64-linux = f "x86_64-linux"; ... }'.
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      # Nixpkgs instantiated for supported system types.
      nixpkgsFor = forAllSystems (system: import nixpkgs {
        inherit
          overlays
          system;
      });
    in
    {

      # define devShell for aysstem with packages
      devShells = forAllSystems (system:
        let
          pkgs = nixpkgsFor.${system};
        in
        {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              nil
            ];
          };
        });

      # define formatter for all systems
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixpkgs-fmt);

      # My reserved desktop configuration as NixOS
      nixosConfigurations.ereshkigal =
        let pkgs = nixpkgsFor.x86_64-linux; in nixpkgs.lib.nixosSystem {
          inherit pkgs;
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            # import root configuration
            ./configuration.nix
            ./home-manager/gui/emacs

            # home-manager support
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.derui = import ./home.nix;
            }
          ];
        };

      # My old desktop
      homeConfigurations.my-gentoo =
        let
          system = "x86_64-linux";
          pkgs = nixpkgsFor.${system};
        in
        home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs;

          extraSpecialArgs = {
            inherit inputs;
          };
          modules = [
            ./home.nix
            ./home-manager/gui/emacs
          ];
        };
    };
}
