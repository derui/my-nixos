{ home, config, ... }:
{
  # ideavimのsourceはdotfileをそのまま配置する形式にする
  home.file.".ideavimrc" = {
    source = ./ideavimrc;
  };
}
