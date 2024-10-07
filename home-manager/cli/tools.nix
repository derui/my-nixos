{ pkgs, ... }:
{
  home.packages = with pkgs; [
    dropbox
  ];
}
