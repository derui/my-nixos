{
  # 無線LANを設定するための処理をNetworkManager経由で行う
  networking.networkmanager = {
    enable = true;
    insertNameservers = [ "1.1.1.1" "1.0.0.1" "2606:4700:4700::1111" "2606:4700:4700::1001" ];
    dns = "dnsmasq";
  };

  services.dnsmasq = {
    enable = true;
    settings = {
      server = [ "1.1.1.1" "1.0.0.1" "2606:4700:4700::1111" "2606:4700:4700::1001" ];
    };
  };
}
