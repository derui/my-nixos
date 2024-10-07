{ pkgs, ... }:
{
  nix = {
    package = pkgs.nix;
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [
        "root"
        "derui"
      ];
      accept-flake-config = true;
    };
  };

  nixpkgs.config.allowUnfree = true;
}
