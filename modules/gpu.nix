{ pkgs, ... }:
{
  hardware.graphics.extraPackages = [
    pkgs.amdvlk
  ];

  # for 32bit application
  hardware.graphics.extraPackages32 = [
    pkgs.driversi686Linux.amdvlk
  ];

  # for AMDGPU
  hardware.amdgpu.amdvlk.enable = true;
}
