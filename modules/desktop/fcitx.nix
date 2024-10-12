{ pkgs, inputs, ... }:
let
  # 自作のpackageはflakeを通してoutputsに入ってくる。
  myPackages = inputs.self.outputs.packages.${pkgs.system};
in
{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";

    fcitx5.addons = with pkgs; [
      myPackages.fcitx5-mozc
      fcitx5-gtk
    ];
  };
}
