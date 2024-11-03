{ pkgs, ... }:
{

  services.tabby = {
    enable = true;
    acceleration = "cpu";
  };
}
