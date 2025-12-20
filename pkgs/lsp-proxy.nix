{
  fetchFromGitHub,
  pkgs,
  ...
}:
pkgs.rustPlatform.buildRustPackage rec {
  pname = "lsp-proxy";
  version = "v0.5.15";

  cargoHash = "sha256-acL6fHH0a690fnO5zk2s18c1zJayF8Hc3DzNVu9om54=";
  src = fetchFromGitHub {
    owner = "jadestrong";
    repo = "lsp-proxy";
    fetchSubmodules = true;
    rev = "88312f26e580e5d334d2c9b85a4b19a3951cdc49";
    hash = "sha256-Cbih5fvANt5fIfAtNfVJoTxC/R6buujtygLZ+HNrDgg=";
  };
}
