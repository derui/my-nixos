{ pkgs, pkgs-stable, ... }:
{
  programs.git = {
    enable = true;
    userName = "derui";
    userEmail = "derutakayu@gmail.com";

    delta.enable = true;

    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
