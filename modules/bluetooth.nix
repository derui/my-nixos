{ ... }:
{
  hardware.bluetooth = {
    enable = true;

    settings = {

      General = {
        # for low-energy support
        Privacy = "device";
        ControllerMode = "dual";
        UserspaceHID = true;
        ClassicBondedOnly = false;
        LEAutoSecurity = false;
      };

      LE = {
        # for xpadneo recommendation
        MinConnectionInterval = 7;
        MaxConnectionInterval = 9;
        ConnectionLatency = 0;
      };

    };
  };
}
