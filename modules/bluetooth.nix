{...}:
{
  hardware.bluetooth = {
    enable = true;

    settings = {

      General = {
        # for low-energy support
        Privacy = "device";
        ControllerMode = "dual";
      };
      
    };
  };
}
