{ pkgs, inputs, ... }:
{
  home.packages = [ pkgs.kitty ];
  xdg.configFile = {
    "kitty/kitty.conf".source = ./kitty.conf;
  };
}
