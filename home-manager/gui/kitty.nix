{ home, config, ... }:
{
  # kittyのsourceはdotfileをそのまま配置する形式にする
  home.file."${config.xdg.configHome}/kitty/kitty.conf" = {
    source = ./kitty.conf;
  };
}
