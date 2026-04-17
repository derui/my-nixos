{ pkgs, ... }:
{
  # enable llama.cpp
  service.llama-cpp = {
    enable = true;

    package = pkgs.llama-cpp-rocm;
    port = 18080;
  };
}
