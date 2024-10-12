{ lib, pkgs, stdenv, fetchgit, ... }:
let
  pname = "tuna-lv2";
in
stdenv.mkDerivation {
  inherit pname;

  version = "0.6.6";

  buildInputs = with pkgs; [
    lv2
    git
    pkg-config
    fftwFloat
    cairo
    pango
    glew
    jack2
  ];

  src = fetchgit {
    url = "https://github.com/x42/tuna.lv2.git";
    fetchSubmodules = true;
    rev = "47b86382dadb4a4bb8129d972cec1aebcd356ce2";
    hash = "sha256-hZrmNZPzj0xWgXaRlBn+G9tPRsPiWT1WmxYL805DWag=";
  };

  buildPhase = ''
    make submodules
    make
  '';

  installPhase = ''
    make install PREFIX=$out/usr
  '';

  meta = with lib; {
    description = "An musical instrument tuner with strobe characteristics in LV2 plugin format.";
    homepage = "https://github.com/x42/tuna.lv2";
    license = licenses.gpl2;
    platforms = platforms.all;
  };
}
  
