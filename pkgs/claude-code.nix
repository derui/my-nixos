#https://github.com/sadjow/claude-code-nix/issues/165

{
  lib,
  stdenv,
  fetchurl,
  patchelf,
  glibc,
}:

let
  version = "2.1.27";

  baseUrl = "https://storage.googleapis.com/claude-code-dist-86c565f3-f756-42ad-8dfa-d59b1c096819/claude-code-releases";

  platformInfo = {
    "x86_64-linux" = {
      platform = "linux-x64";
      hash = "JN+R3SULbX9qD4slav+rbHpL3vpksezorKMjXV9eQEQ=";
    };
  };

  info =
    platformInfo.${stdenv.hostPlatform.system}
      or (throw "Unsupported platform: ${stdenv.hostPlatform.system}");
in
stdenv.mkDerivation {
  pname = "claude-code";
  inherit version;

  src = fetchurl {
    url = "${baseUrl}/${version}/${info.platform}/claude";
    sha256 = info.hash;
  };

  dontUnpack = true;
  dontPatchELF = true; # We handle patching ourselves
  dontStrip = true; # Stripping corrupts the Bun embedded payload

  nativeBuildInputs = [ patchelf ];

  buildPhase = ''
    runHook preBuild

    # Copy and patch in build dir (writable)
    cp $src claude
    chmod u+w,+x claude

    # Only patch the interpreter, nothing else
    patchelf --set-interpreter "${glibc}/lib/ld-linux-x86-64.so.2" claude

    # Verify the Bun trailer is still intact
    if ! tail -c 20 claude | grep -q "Bun!"; then
      echo "ERROR: Bun trailer was corrupted by patchelf!"
      exit 1
    fi

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp claude $out/bin/claude
    runHook postInstall
  '';

  meta = with lib; {
    description = "Claude Code - AI coding assistant in your terminal";
    homepage = "https://www.anthropic.com/claude-code";
    platforms = [ "x86_64-linux" ];
    mainProgram = "claude";
  };
}
