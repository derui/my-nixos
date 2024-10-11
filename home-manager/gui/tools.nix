{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bitwarden-desktop

    wofi # program launcher
    waybar # bar display
    mako

    # music
    ardour
    pipewire # for pw-jack
    pavucontrol

    # video
    celluloid
  ];
}
