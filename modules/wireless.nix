{
  # 無線LANを設定するための処理をNetworkManager経由で行う
  networking.networkmanager = {
    enable = true;

    insertNameservers = [ "1.1.1.1" "1.0.0.1" "2606:4700:4700::1111" "2606:4700:4700::1001" ];
  };

  networking.supplicant = {
    "wlp8s0" = {
      configFile.path = "/etc/nixos/secrets/wpa_supplicant.conf";
      extraConf = ''
        ap_scan=1
        p2p_disabled=1
      '';
    };
  };

}
