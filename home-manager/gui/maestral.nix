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
    serviceConfig = {
      ExecStart = "${pkgs.maestral}/bin/maestral start";
      PreStop = "${pkgs.maestral}/bin/maestral stop";
      Restart = "on-failure";
    };
  };
}
