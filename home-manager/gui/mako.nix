{ home, config, ... }:
{
  # makoのsourceはdotfileをそのまま配置する形式にする
  home.file."${config.xdg.configHome}/mako/config" = {
    source = ./mako.conf;
  };
}
