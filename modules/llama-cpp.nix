{ pkgs, user, ... }:
{

  environment.etc."llama-swap/config.yaml".text = ''
    # llama-swap configuration
    # This config uses llama.cpp's server to serve models on demand

    models:  # Ordered from newest to oldest

      "gemma-4:4b":
        cmd: |
          ${pkgs.llama-cpp}/bin/llama-server
          -hf google/gemma-4-E4B-it-GGUF
          --port ''${PORT}
          --ctx-size 131072
          --batch-size 2048
          --ubatch-size 512
          --threads 16
          --jinja

    healthCheckTimeout: 600  # 10 minutes for large model download + loading

    # TTL keeps models in memory for specified seconds after last use
    ttl: 3600  # Keep models loaded for 1 hour (like OLLAMA_KEEP_ALIVE)
  '';

  # Configure llama-swap as a systemd service
  systemd.services.llama-swap = {
    description = "llama-swap - OpenAI compatible proxy with automatic model swapping";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "simple";
      User = "${user}";
      Group = "users";
      # Point to your declarative config file
      ExecStart = "${pkgs.llama-swap}/bin/llama-swap --config /etc/llama-swap/config.yaml --listen 0.0.0.0:9292 --watch-config";
      Restart = "always";
      RestartSec = 10;

      # Environment for CUDA support
      Environment = [
        "PATH=/run/current-system/sw/bin"
        "LD_LIBRARY_PATH=/run/opengl-driver/lib:/run/opengl-driver-32/lib"
      ];
    };
  };
}
