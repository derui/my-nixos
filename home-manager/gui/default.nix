{ pkgs, useLLM, ... }:
{
  imports = [
    ./hyprland.nix
    ./kitty.nix
    ./waybar.nix
    ./mako.nix
    ./intellij
    ./tools.nix
    (import ./emacs { inherit pkgs useLLM; })
    ./firefox.nix
    ./maestral.nix
  ];

}
