{ pkgs, lib, ... }:
let
  llama-cpp = pkgs.llama-cpp.override {
    rocmSupport = true;
  };
  llama-server = lib.getExe' llama-cpp "llama-server";
in
{
  systemd.services.llama-swap = {
    environment.XDG_CACHE_HOME = "/var/cache/llama.cpp";
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
        "gemma-4-nt:12b" = {
          cmd = "${llama-server} -dev ROCm0 -hf unsloth/gemma-4-12b-it-GGUF:Q4_K_S --port \${PORT} --n-gpu-layers 999 --repeat-penalty 1.0 --reasoning off --spec-type draft-mtp --spec-draft-n-max 2";
        };
        "gemma-4-it:12b" = {
          cmd = "${llama-server} -dev ROCm0 -hf unsloth/gemma-4-12b-it-GGUF:Q4_K_S --port \${PORT} --n-gpu-layers 999 --repeat-penalty 1.0 --reasoning on --spec-type draft-mtp --spec-draft-n-max 2";
        };
        "qwen3.6:27b" = {
          cmd = "${llama-server} -dev ROCm0 -hf unsloth/Qwen3.6-27B-MTP-GGUF:IQ4_XS --port \${PORT} \\
             -ngl 99 -c 8192 -fa on -np 1 \\
             --spec-type draft-mtp \\
             --spec-draft-n-max 2";
        };
      };
    };
  };
}
