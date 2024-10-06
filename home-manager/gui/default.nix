{ pkgs, ... }:
{
  imports = [
    ./hyprland.nix
    ./kitty.nix
    ./waybar.nix
    ./mako.nix
    ./intellij
    ./tools.nix
  ];
}
