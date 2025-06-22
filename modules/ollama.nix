{ pkgs, ... }:
{
  services.ollama = {
    # re-enable after https://github.com/NixOS/nixpkgs/pull/418461 is merged
    #enable = true;
    acceleration = "rocm";
    group = "ollama";

    environmentVariables = {
      HSA_OVERRIDE_GFX_VERSION = "11.0.0";
      # for gemma3
      OLLAMA_FLASH_ATTENTION = "0";
    };
  };
}
