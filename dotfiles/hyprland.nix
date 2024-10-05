{...}:
{
  wayland.windowManager.hyprland = {
    enable = true;
  };

  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    "$terminal" = "kitty";
    "$menu" = "wofi --show drun";
    exec-once = [
      "waybar"
      "fcitx5 -rd"
      "mako"
    ];

    input = {
      kb_layout = "us";
      follow_mouse = 1;
      sensitivity = 0;
    };

    general = {
      gaps_in = 5;
      gaps_out = 10;
      border_size = 2;
      col.active_border = "rgba(33ccffee) rgba(00ff99ee) 45deg";
      col.inactive_border = "rgba(595959aa)";
  
      layout = "dwindle";
  
      # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
      allow_tearing = false;
    };

    decoration = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
    
        rounding = 10;
    
        blur = {
            enabled = true;
            size = 3;
            passes = 1;
            
            vibrancy = 0.1696;
        };
    
        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        col.shadow = "rgba(1a1a1aee)";
    };
    
    animations = {
        enabled = true;
    
        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
    
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
    
        animation = [
          "windows, 1, 7, myBezier"
        "windowsOut, 1, 7, default, popin 80%"
        "border, 1, 10, default"
        "borderangle, 1, 8, default"
        "fade, 1, 7, default"
        "workspaces, 1, 2, default"
        ];
    };

    dwindle = {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = true; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true; # you probably want this
    };

    gestures = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        workspace_swipe = false;
    };

    misc = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        force_default_wallpaper = -1; # Set to 0 or 1 to disable the anime mascot wallpapers
    };
    
    windowrulev2 =[
      "suppressevent maximize, class:.*" # You'll probably like this.
     "immediate, class:^(cs2)$"
     ];

    bind =
      [
        "$mod, Enter, exec, firefox"
        ", Print, exec, grimblast copy area"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (i:
            let ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
          9)
      );
  };
}
