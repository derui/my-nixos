{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bitwarden-desktop
    firefox

    wofi # program launcher
    waybar # bar display
    mako

    # music
    ardour
    pipewire # for pw-jack
  ];
}
