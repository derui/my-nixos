{ pkgs, user, ... }:
{
  # syncthingはデフォルトではSyncというfolderを作るが、nixではいらないので消しておく
  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true";

  services.syncthing = {
    enable = true;
    # default portを開ける。22000と21027
    openDefaultPorts = true;

    user = user;
    configDir = "/home/${user}/.conifg/syncthing";

    settings = {
      devices = {
        "my-phone" = {
          id = "BIW62GN-J7JWHF5-IRX3C3B-MXXNZLE-56MXRYN-WIIYCTI-RF2WJZD-CPFR5QG";
        };
        "NOTE2" = {
          id = "GTAC5U5-XLBY674-UMUNUFF-3W2CNXO-CKC672X-HE5USUG-PNH2PYF-RIL3SQF";
        };
      };

      folders = {
        "Org" = {
          path = "/home/${user}/Documents";
          devices = [
            "my-phone"
            "NOTE2"
          ];
        };
      };
    };

  };
}
