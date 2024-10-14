{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.ollama-rocm ];
  services.ollama = {
    enable = true;
    acceleration = "rocm";
    group = "ollama";

    environmentVariables = {
      HCC_AMDGPU_TARGET = "gfx1100"; # used to be necessary, but doesn't seem to anymore
    };
    rocmOverrideGfx = "11.0.0";
  };
}
