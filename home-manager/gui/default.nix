{ inputs, pkgs, useLLM, ... }:
{
  imports = [
    ./tools.nix
    (import ./emacs { inherit inputs pkgs; })
    ./firefox.nix
    ./maestral.nix
  ];

}
