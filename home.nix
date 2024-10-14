{ user, ... }:
{
  home.username = user;
  home.homeDirectory = "/home/${user}";

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
