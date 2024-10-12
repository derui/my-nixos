{ pkgs, inputs, ... }:
let
  mypkgs = inputs.self.outputs.packages.${pkgs.system};
in
{
  home.packages = with pkgs; [
    bitwarden-desktop

    wofi # program launcher
    waybar # bar display
    mako

    # music
    ardour
    mypkgs.tuna-lv2
    pipewire.jack # for pw-jack
    pavucontrol

    # video
    celluloid

    blueman # bluetooth frontend

    # multimedia
    yacreader
  ];
}
