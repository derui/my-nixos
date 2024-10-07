{ config, pkgs, inputs, ... }:
{
  home.username = "derui";
  home.homeDirectory = "/home/derui";

  # imports software
  imports =
    [
      ./home-manager/gui
      ./home-manager/cli
    ];

  # home manager version
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
  # fontをインストールできるように
  fonts.fontconfig.enable = true;
}
