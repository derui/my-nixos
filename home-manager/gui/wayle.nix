{ pkgs, inputs, ... }:
{
  services.wayle = {
    enable = true;

    # Whether to automatically install soft dependencies used by wayle that
    # will be required based on your config.
    autoInstallDependencies = true;

    # tip: you can automatically translate your TOML config to Nix by running
    # nix-instantiate --eval --expr 'builtins.fromTOML (builtins.readFile ./config.toml)' | nixfmt
    settings = {
      bar = {
        layout = [
          # add more attribute sets with different monitors if wayle should
          # have different layouts on each
          {
            monitor = "*"; # replace "DP-1" with "*" for all monitors
            show = true;
            center = [
              "window-title"
            ];
            left = [
              "dashboard"
              "hyprland-workspaces"
            ];
            right = [
              "network"
              "cpu"
              "ram"
              "volume"
              "clock"
              "systray"
            ];
          } # this is a 'list' of 'attribute sets', no semi-colons after the closing braces needed
        ];
      };
      modules = {
        clock = {
          format = "%Y/%m/%d %H:%M:%S";
          dropdown-show-seconds = false;
        };
        wayland-workspaces = {
          workspace-padding = 1.0;
        };
      };
      osd = {
        enabled = false;
      };
      styling = {
        scale = 1.25;
        # wallust will be automatically installed if this is set
        theme-provider = "wallust";
      };
    };
  };
}
