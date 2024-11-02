{
  lib,
  stdenv,
  fetchFromGitHub,
  kernel,
}:

stdenv.mkDerivation {
  pname = "rtl8126";
  version = "${kernel.version}-unstable-2024-06-23";

  src = fetchFromGitHub {
    owner = "openwrt";
    repo = "rtl8126";
    rev = "7262bb22bd3a20dfb47124c76d6b11587b3c5e78";
    hash = "sha256-SsmgsaGzOaRZl9RuUDbVnw+xr2AmC32FXEOgQpZSel8=";
  };

  nativeBuildInputs = kernel.moduleBuildDependencies;
  makeFlags = kernel.makeFlags;

  prePatch = ''
    substituteInPlace ./Makefile \
      --replace-warn /lib/modules/ "${kernel.dev}/lib/modules/"
  '';

  patches = [
    ./ethtool_type_change.patch
  ];

  installPhase = ''
    mkdir -p "$out/lib/modules/${kernel.modDirVersion}/kernel/net/ethernet/"
    cp $NIX_BUILD_TOP/source/r8126.ko "$out/lib/modules/${kernel.modDirVersion}/kernel/net/ethernet/"
  '';

  enableParallelBuilding = true;

  meta = with lib; {
    description = "Realtek rtl8126 driver";
    homepage = "https://github.com/openwrt/rtl8126";
    license = licenses.gpl2Only;
    platforms = platforms.linux;
  };
}
