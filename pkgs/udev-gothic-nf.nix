{
  stdenvNoCC,
  lib,
  fetchzip,
  nixosTests,
  ...
}:
let
  version = "2.0.0";
  sha256 = "sha256-u3iv5IilWysw9v8v4AfN7ucNM+eNbKVR2kfQn7JH/AM=";
in
stdenvNoCC.mkDerivation {
  pname = "udev-gothic-nf";
  inherit version;

  src = fetchzip {
    url = "https://github.com/yuru7/udev-gothic/releases/download/v2.0.0/UDEVGothic_NF_v2.0.0.zip";
    hash = sha256;
    stripRoot = true;
  };

  installPhase = ''
    install -m444 -Dt $out/share/fonts/truetype/udev-gothic-nf *.ttf
  '';

  passthru.tests.noto-fonts = nixosTests.noto-fonts;

  meta = with lib; {
    description = "UDEV Gothic は、ユニバーサルデザインフォントの BIZ UDゴシック と、 開発者向けフォントの JetBrains Mono を合成した、プログラミング向けフォントです。";
    homepage = "https://github.com/yuru7/udev-gothic/";
    longDescription = ''
      以下の特徴を備えています。

          モリサワ社の考えるユニバーサルデザインが盛り込まれたBIZ UDゴシック由来の読み易い日本語文字
          IntelliJ などの開発環境を提供することで知られる JetBrains 社が手掛けた JetBrains Mono 由来のラテン文字
              0 を従来のドットゼロからスラッシュゼロにするなど、BIZ UDゴシックとさらに調和することを目指した。
          BIZ UDゴシック相当の IVS (異体字シーケンス) に対応 (対応している異体字リストは こちら)
          全角スペースの可視化
          収録される文字の違い等によって分かれた複数のバリエーションを用意 (下記参照)
    '';
    license = licenses.ofl;
    platforms = platforms.all;
    maintainers = [ ];
  };
}
