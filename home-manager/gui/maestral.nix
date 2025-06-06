{ pkgs, ... }:
{
  home.packages = [ pkgs.maestral ];

  systemd.user.services.maestral = {
    Unit = {
      Description = "Maestral service";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      ExecStart = "${pkgs.maestral}/bin/maestral start --foreground";
      Type = "exec";
      Restart = "on-failure";
    };
  };
}
