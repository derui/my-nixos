{ inputs, user, useLLM, pkgs, ... }:
{
  home.username = user;
  home.homeDirectory = "/home/${user}";

  # imports software
  imports =
    [
      (import ./home-manager/gui { inherit pkgs useLLM; })
      (import ./home-manager/cli { inherit inputs pkgs useLLM; })
    ];

  # home manager version
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
  # fontをインストールできるように
  fonts.fontconfig.enable = true;
}
