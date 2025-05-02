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
    dnssec = "allow-downgrade";
    domains = [ "~." ];
    fallbackDns = [
      "1.1.1.1"
      "1.0.0.1"
      "2606:4700:4700::1111"
      "2606:4700:4700::1001"
    ];
    dnsovertls = "opportunistic";
  };
}
