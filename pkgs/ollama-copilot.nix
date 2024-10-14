{ lib, pkgs, buildGoModule, fetchFromGitHub, ... }:
buildGoModule {
  pname = "ollama-copilot";
  version = "0.1";

  src = fetchFromGitHub {
    owner = "bernardo-bruning";
    repo = "ollama-copilot";

    rev = "96be23af01e5b5adf8c096dfeef64ab9c2101d1e";
    sha256 = "sha256-0qNTQHT0aAPd4F6eAAcw1/HWA9BkpmVNIbvzVbehqsc=";
  };

  vendorHash = "sha256-g27MqS3qk67sve/jexd07zZVLR+aZOslXrXKjk9BWtk=";

  meta = {
    description = "Proxy that allows you to use ollama as a copilot like Github copilot";
    homepage = "https://github.com/bernardo-bruning/ollama-copilot";
    license = lib.licenses.mit;
  };
}

