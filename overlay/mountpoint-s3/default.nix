final: prev: {
  mountpoint-s3 = prev.mountpoint-s3.overrideAttrs (oldAttrs: rec {
    version = "1.21.0";
    src = prev.fetchFromGitHub {
      owner = "awslabs";
      repo = "mountpoint-s3";
      tag = "v${version}";
      hash = "sha256-CybWj5oHVPzXIvC0Rif8zdt/r0Sow8Nlw8ORVzALG9o=";
      fetchSubmodules = true;
    };
    cargoDeps = prev.rustPlatform.fetchCargoVendor {
      inherit src;
      hash = "sha256-qsHem97DoW272+efNqJENLVe7UKcYUzb8owKEN5ymwo=";
    };
    doCheck = false;
  });
}
