{...}:
{
  hardware.bluetooth = {
    enable = true;

    settings = {
      # for low-energy support
      "Privacy" = "device";

      ControllerMode = "dual";
    };
  };
}
