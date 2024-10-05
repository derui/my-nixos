{ pkgs, inputs, ... }:
{
  imports = [
    ./git.nix
    ./starship.nix
  ];
}
