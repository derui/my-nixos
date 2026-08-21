{ pkgs, lib, ... }:
let
  llama-cpp = pkgs.llama-cpp.override {
    vulkanSupport = true;
  };
  llama-server = lib.getExe' llama-cpp "llama-server";
in
{
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
        "ornith1.5:31b" = {
          cmd = "${llama-server} -dev ROCm0 -hf ornith-ai/Ornith-1.5-35B-A3B-GGUF:Q4_K_M --port \${PORT} \\
             -ngl 99 -np 1 --n-cpu-moe 6 \\
             --temp 1.0 \\
             --top-p 0.95 \\
             --top-k 20 \\
             --min-p 0.0 \\
             --flash-attn on \\
             --cache-type-k q4_0 \\
             --cache-type-v q4_0 \\
             --spec-type draft-mtp \\
             --spec-draft-n-max 2";
        };
        "Muse-Glimmer:30b" = {
          cmd = "${llama-server} -dev ROCm0 -hf unsloth/Muse-Glimmer-30B-GGUF:UD-Q4_K_XL --port \${PORT} \\
             --chat-template-kwargs '{\"reasoning_effort\":\"low\"}' \\
             -ngl 99 -np 1 \\
             --temp 1.0 \\
             --top-p 0.95 \\
             --top-k 20 \\
             --min-p 0.0 \\
             --flash-attn on \\
             --cache-type-k q4_0 \\
             --cache-type-v q4_0";
        };
      };
    };
  };
}
