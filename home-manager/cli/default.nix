{ inputs, pkgs, useLLM, ... }:
{
  imports = [
    ./git.nix
    ./starship.nix
    ./fish.nix
    ./nix.nix
    ./development.nix
    ./newsboat.nix
    ./tools.nix
  ];
}
