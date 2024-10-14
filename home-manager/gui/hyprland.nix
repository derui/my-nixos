{ ... }:
{
  xdg.configFile = {
    "hypr/hyprland.conf".source = ./hyprland.conf;
  };
  wayland.windowManager.hyprland = {
    enable = true;
  };
}
