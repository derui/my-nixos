{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.ollama-rocm ];
  services.ollama = {
    enable = true;
    acceleration = "rocm";
    group = "ollama";

    environmentVariables = {
      HCC_AMDGPU_TARGET = "gfx1100"; # used to be necessary, but doesn't seem to anymore
      OLLAMA_FLASH_ATTENTION = "1";
    };
    loadModels = [
      "qwen2.5-coder:14b-base-q8_0"
    ];
    rocmOverrideGfx = "11.0.0";
  };
}
