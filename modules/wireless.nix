{
  # 無線LANを設定するための処理
  networking.wireless = {
    enable = true;

    secretsFile = "/run/secrets/wireless.conf";

    networks = {
      "18:EC:E7:28:9D:8A" = {
        # SSID with no spaces or special characters
        pskRaw = "ext:psk_home"; # (password will be written to /nix/store!)
      };
    };
  };

}
