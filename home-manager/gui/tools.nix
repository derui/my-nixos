{ pkgs, inputs, ... }:
let
  mypkgs = inputs.self.outputs.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  home.packages = with pkgs; [
    bitwarden-desktop

    kitty
    wofi # program launcher
    waybar # bar display
    mako

    # music
    ardour
    mypkgs.tuna-lv2
    pipewire.jack # for pw-jack
    pavucontrol

    # video
    vlc

    # wayland misc
    wl-clipboard

    blueman # bluetooth frontend

    # multimedia
    yacreader
  ];
}
