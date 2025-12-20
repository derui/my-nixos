{
  inputs,
  pkgs,
  useLLM,
  lib,
  ...
}:
{
  imports = [
    ./tools.nix
    (import ./emacs { inherit inputs pkgs lib; })
    ./firefox.nix
    ./maestral.nix
  ];

}
