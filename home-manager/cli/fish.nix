{ home, config, ... }:
{
  programs.fish = {
    enable = true;

    # https://github.com/bouk/babelfish
    # babelfishを使ってglobalの設定をfishにcopyする
    #useBabelfish = true;
  };

  # 設定ファイルはかなりの規模になっているので、recursiveする形にする。
  home.file."${config.xdg.configHome}/fish/" = {
    recursive = true;
    source = ./fish;
  };

}
