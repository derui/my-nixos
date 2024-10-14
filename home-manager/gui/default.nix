{ inputs, pkgs, useLLM, ... }:
{
  imports = [
    ./hyprland.nix
    ./kitty.nix
    ./waybar.nix
    ./mako.nix
    ./intellij
    ./tools.nix
    (import ./emacs { inherit inputs pkgs useLLM; })
    ./firefox.nix
    ./maestral.nix
  ];

}
