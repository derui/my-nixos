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
      ExecStart = "${pkgs.maestral}/bin/maestral start";
      ExecStop = "${pkgs.maestral}/bin/maestral stop";
      Restart = "on-failure";
    };
  };
}
