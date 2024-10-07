{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bitwarden-desktop
    firefox
  ];
}
