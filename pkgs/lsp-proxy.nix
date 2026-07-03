{
  fetchFromGitHub,
  pkgs,
  ...
}:
pkgs.rustPlatform.buildRustPackage {
  pname = "lsp-proxy";
  version = "v0.8.2";

  cargoHash = "sha256-NmG3+FexaCuoQRf1OV/OcktSKYMXJHWh+cBzJToQl+M=";
  src = fetchFromGitHub {
    owner = "jadestrong";
    repo = "lsp-proxy";
    fetchSubmodules = true;
    rev = "e40e8cb9e131f37a88224a0b207cb6e920d22e11";
    hash = "sha256-gCD7FC6uc8rypeGaFwYgP2Xrf7smDs8iMCyHY1qxd3M=";
  };

  doCheck = false;
}
