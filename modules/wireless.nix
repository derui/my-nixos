{ config, ... }:
{
  networking.networkmanager.insertNameservers = [
    "1.1.1.1"
    "1.0.0.1"
    "2606:4700:4700::1111"
    "2606:4700:4700::1001"
  ];
  networking.resolvconf.dnsExtensionMechanism = false;

  services.nscd = {
    enable = true;
  };

  services.resolved = {
    enable = true;

    settings = {
      Resolve = {
        Domains = [ "~." ];

        DNSSEC = "allow-downgrade";
        DNSOverTLS = "opportunistic";
        FallbackDNS = [
          "1.1.1.1"
          "1.0.0.1"
          "2606:4700:4700::1111"
          "2606:4700:4700::1001"
        ];
      };
    };

  };
}
