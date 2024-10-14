{ pkgs, ... }:
{
  copilot-node-server = pkgs.callPackage ./copilot-node-server.nix { };
}
