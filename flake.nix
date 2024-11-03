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

    # Rust tool management
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # my dotfile manager
    dotfiles.url = "github:derui/dotfiles";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      emacs-overlay,
      fenix,
      dotfiles,
      ...
    }@inputs:
    let
      overlays = [
        (import emacs-overlay)
        fenix.overlays.default
        (import ./overlays/gtk3)
        (import ./overlays/tabby)
      ];

      # System types to support.
      supportedSystems = [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      # Helper function to generate an attrset '{ x86_64-linux = f "x86_64-linux"; ... }'.
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      # Nixpkgs instantiated for supported system types.
      nixpkgsFor = forAllSystems (
        system:
        import nixpkgs {

          inherit
            overlays
            system
            ;

          # ここで指定しておかないと、OS configurationの方にも反映できない。
          config = {
            allowUnfree = true;
          };
        }
      );
    in
    {
      # 自作のpackageをoutputに追加する
      packages = forAllSystems (system: import ./pkgs inputs.nixpkgs.legacyPackages.${system});

      # define devShell for aysstem with packages
      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgsFor.${system};
        in
        {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              nh
            ];
          };
        }
      );

      # define formatter for all systems
      formatter = forAllSystems (system: nixpkgsFor.${system}.nixfmt-rfc-style);

      # My reserved desktop configuration as NixOS
      nixosConfigurations.ereshkigal =
        let
          system = "x86_64-linux";
          user = "derui";
        in
        nixpkgs.lib.nixosSystem {
          inherit system;
          pkgs = nixpkgsFor.${system};

          specialArgs = {
            inherit inputs user;
          };
          modules = [
            ./configuration.nix
          ];
        };
      homeConfigurations."derui@ereshkigal" =
        let
          system = "x86_64-linux";
          user = "derui";
        in
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgsFor.${system};

          extraSpecialArgs = {
            inherit inputs user;
            useLLM = true;
          };
          modules = [
            ./home.nix
            dotfiles.nixosModules.default
          ];
        };

      # My old desktop
      homeConfigurations."derui@my-gentoo" =
        let
          system = "x86_64-linux";
          user = "derui";
        in
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgsFor.${system};

          extraSpecialArgs = {
            inherit inputs user;
            useLLM = false;
          };
          modules = [
            ./home.nix
          ];
        };
    };
}
