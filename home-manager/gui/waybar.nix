{ ... }:
{
  # waybarの設定は結構独自なので、自分で設定する
  xdg.configFile = {
    "waybar/config".source = ./waybar.conf;
    "waybar/style.css".source = ./waybar.style.css;
  };
}
