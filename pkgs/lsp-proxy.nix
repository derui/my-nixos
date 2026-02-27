{
  fetchFromGitHub,
  pkgs,
  ...
}:
pkgs.rustPlatform.buildRustPackage rec {
  pname = "lsp-proxy";
  version = "v0.7.2";

  cargoHash = "sha256-GuenUBYjU36N8qenkGo2WjfJfQwUdjBKAq3mYDgUIJE=";
  src = fetchFromGitHub {
    owner = "jadestrong";
    repo = "lsp-proxy";
    fetchSubmodules = true;
    rev = "08a6f7c01135db8a09f6a75cf8ffecb7d8010ba5";
    hash = "sha256-Q82KmTJDBOeN9uYVlvtCIPsXcM+vX0/HheKwgH+Gqk0=";
  };
}
