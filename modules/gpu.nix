{ pkgs, ...}:
{
  hardware.opengl.extraPackages = [
    pkgs.amdvlk
  ];

  # for 32bit application
  hardware.opengl.extraPackages32 = [
    pkgs.driversi686Linux.amdvlk
  ]
}
