{ pkgs, ... }:
{
  services.ollama = {
    enable = true;
    acceleration = "rocm";
    group = "ollama";

    environmentVariables = {
      HSA_OVERRIDE_GFX_VERSION = "11.0.0";
      OLLAMA_FLASH_ATTENTION = "1";
    };
    loadModels = [
      "qwen2.5-coder:14b-base-q8_0"
    ];
  };
}
