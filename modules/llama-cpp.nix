{ pkgs, lib, ... }:
let
  llama-cpp = pkgs.llama-cpp.override {
    blasSupport = true;
    rocmSupport = true;
  };
  llama-server = lib.getExe' llama-cpp "llama-server";
in
{
  systemd.services.llama-swap = {
    environment.XDG_CACHE_HOME = "/var/cache/llama.cpp";
    serviceConfig.CacheDirectory = "llama.cpp";
  };

  # for debug
  # environment.systemPackages = [llama-cpp];

  services.llama-swap = {
    enable = true;
    port = 9292;

    settings = {
      healthCheckTimeout = 600;
      ttl = 3600;

      models = {
        "gemma-4:4b" = {
          cmd = "${llama-server} -dev ROCm0 -hf ggml-org/gemma-4-E4B-it-GGUF --port \${PORT} --n-gpu-layers 999 --repeat-penalty 1.0 ";
        };
      };
    };
  };
}
