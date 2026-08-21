{
  stdenvNoCC,
  lib,
  fetchzip,
  ...
}:
let
  version = "3.1.0";
  sha256 = "sha256-7DVWDxciW5pEuaIdIinibwPi7QjNsQBPFq/wtP+fTeg=";
in
stdenvNoCC.mkDerivation {
  pname = "PlemolJP";
  inherit version;

  src = fetchzip {
    url = "https://github.com/yuru7/PlemolJP/releases/download/v3.1.0/PlemolJP_NF_v3.1.0.zip";
    hash = sha256;
    stripRoot = true;
  };

  installPhase = ''
    install -m444 -Dt $out/share/fonts/truetype/premoljp PlemolJPConsole_NF/*.ttf
  '';

  meta = with lib; {
    description = "IBM Plex Mono と IBM Plex Sans JP を合成した日本語プログラミングフォント PlemolJP (プレモル ジェイピー)";
    homepage = "https://github.com/yuru7/PlemolJP";
    longDescription = ''
      PlemolJP では合成元の IBM Plex Mono シリーズと同様に、ノーマル・イタリックの両スタイルに対応しました。また、各スタイルごとに8種のウェイト (Thin~Bold) をご用意しています。

      さらに日本語環境でのプログラミングでつまずきがちな全角スペースの誤入力に気づけるよう、全角スペースを可視化する修正を加えています。
    '';
    license = licenses.ofl;
    platforms = platforms.all;
    maintainers = [ ];
  };
}
