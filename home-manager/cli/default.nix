{ pkgs, inputs, ... }:
{
  imports = [
    ./git.nix
    ./starship.nix
    ./fish.nix
    ./nix.nix
  ];
}
