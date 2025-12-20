{
  inputs,
  user,
  useLLM,
  pkgs,
  lib,
  ...
}:
{
  home.username = user;
  home.homeDirectory = "/home/${user}";

  # imports software
  imports = [
    (import ./home-manager/gui {
      inherit
        inputs
        pkgs
        useLLM
        lib
        ;
    })
    (import ./home-manager/cli {
      inherit
        inputs
        pkgs
        useLLM
        lib
        ;
    })
  ];

  # home manager version
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
  # fontをインストールできるように
  fonts.fontconfig.enable = true;
}
