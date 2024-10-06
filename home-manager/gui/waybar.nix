
{ home, config, ... }:
{
  # waybarの設定は結構独自なので、自分で設定する
  home.file."${config.xdg.configHome}/waybar/config" = {
    source = ./waybar.conf;
  };

  home.file."${config.xdg.configHome}/waybar/style.css" = {
    source = ./waybar.style.css;
  };
}
