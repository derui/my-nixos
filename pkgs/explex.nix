{ stdenvNoCC
, lib
, fetchzip
, nixosTests
, ...
}:
let
  version = "0.0.3";
  sha256 = "sha256-OUmzF8GrwVgFAMSEiZLvh85nsOw1a0a7B70u2cRXXO8=";
in
stdenvNoCC.mkDerivation {
  pname = "explex";
  inherit version;

  src = fetchzip {
    url = "https://github.com/yuru7/Explex/releases/download/v${version}/Explex_v${version}.zip";
    hash = sha256;
    stripRoot = true;
  };

  installPhase = ''
    install -m444 -Dt $out/share/fonts/truetype/explex Explex35/*.ttf
  '';

  passthru.test.explex = nixosTests.explex;

  meta = with lib; {
    description = "Explex は、0xProto と IBM Plex Sans JP を合成した、プログラミング向けフォントです。";
    homepage = "https://github.com/yuru7/explex/";
    longDescription = ''
       以下の特徴を備えています。

      文字形を崩さない控えめなリガチャやテクスチャーヒーリングに対応、コーディングシーンに最適化された 0xProto 由来のラテン文字
      IBM社が提供する IBM Plex Sans JP 由来の読み易い日本語文字
      記号類グリフの豊富な Hack を追加合成することで記号の不足を補完
      全角スペースの可視化
      収録される文字の違い等によって分かれた複数のバリエーションを用意 (下記参照)

    '';
    license = licenses.ofl;
    platforms = platforms.all;
    maintainers = [ ];
  };
}
