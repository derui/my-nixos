{
  description = "A derui's NixOS flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Emacs Head
    emacs-overlay = {
      # for build error avoidance. It seems that Emacs's mirror has some problems
      #url = "github:nix-community/emacs-overlay?rev=7be781d707a05599420a06cdcc3a3a793b17fc4d";
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland
    hyprland = {
      url = "github:hyprwm/Hyprland?submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
      nixos-wsl,
      ...
    }@inputs:
    let
      overlays = [
        (import emacs-overlay)
        fenix.overlays.default
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
            rocmSupport = true;
          };
        }
      );
    in
    {
      # 自作のpackageをoutputに追加する
      packages = forAllSystems (system: import ./pkgs inputs.nixpkgs.legacyPackages.${system});

      # define devShell for a system with packages
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
            ./configurations/ereshkigal.nix
          ];
        };
      nixosConfigurations.nixos =
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
            nixos-wsl.nixosModules.default
            {
              system.stateVersion = "25.05";
              wsl.enable = true;
            }
            ./configurations/wsl.nix
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

      # My WSL
      homeConfigurations."derui@nixos" =
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
            dotfiles.nixosModules.default
          ];
        };
    };
}
