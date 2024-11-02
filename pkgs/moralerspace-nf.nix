{
  stdenvNoCC,
  lib,
  fetchzip,
  nixosTests,
  ...
}:
let
  version = "1.0.2";
  sha256 = "sha256-vBpHwtVxsojiM/B6+Ntwh9WX3gyklHpt1GHsE5QFTjc=";
in
stdenvNoCC.mkDerivation {
  pname = "moralerspace-nf";
  inherit version;

  src = fetchzip {
    url = "https://github.com/yuru7/moralerspace/releases/download/v1.0.2/MoralerspaceNF_v1.0.2.zip";
    hash = sha256;
    stripRoot = true;
  };

  installPhase = ''
    install -m444 -Dt $out/share/fonts/truetype/moralerspace-nf *.ttf
  '';

  passthru.tests.noto-fonts = nixosTests.noto-fonts;

  meta = with lib; {
    description = "Moralerspace は、欧文フォント Monaspace と日本語フォント IBM Plex Sans JP などを合成したプログラミング向けフォントです。";
    homepage = "https://github.com/yuru7/moralerspace";
    longDescription = ''

      Texture healing システムを搭載した、GitHub 製 Monaspace 由来の英数字
      文字の懐が広く読みやすい IBM 製 IBM Plex Sans JP 由来の日本語文字
          Radon 系統には キウイ丸 (Kiwi-Maru) をベースに、足りないグリフを IBM Plex Sans JP で補完
          Krypton 系統には Stick をベースに、足りないグリフを IBM Plex Sans JP で補完
      罫線素片などの一部半角記号は、 Hack より追加合成
      文字幅比率が 半角3:全角5、ゆとりのある半角英数字
          半角1:全角2 幅のバリエーションもあり
      バグの原因になりがちな全角スペースが可視化される

    '';
    license = licenses.ofl;
    platforms = platforms.all;
    maintainers = [ ];
  };
}
