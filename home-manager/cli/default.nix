{
  inputs,
  pkgs,
  useLLM,
  ...
}:
{
  imports = [
    ./nix.nix
    ./development.nix
    ./newsboat.nix
    ./tools.nix
  ];
}
