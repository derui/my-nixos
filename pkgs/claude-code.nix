#https://github.com/sadjow/claude-code-nix/issues/165

{
  lib,
  stdenv,
  fetchurl,
  procps,
  ripgrep,
  bubblewrap,
  socat,
  installShellFiles,
  makeBinaryWrapper,
  autoPatchelfHook,
  writableTmpDirAsHomeHook,
  versionCheckHook,
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
  dontBuild = true;
  dontStrip = true; # Stripping corrupts the Bun embedded payload

  nativeBuildInputs = [
    installShellFiles
    makeBinaryWrapper
  ]
  ++ lib.optionals stdenv.hostPlatform.isElf [ autoPatchelfHook ];

  strictDeps = true;

  installPhase = ''
    runHook preInstall

    installBin $src

    wrapProgram $out/bin/claude \
      --set DISABLE_AUTOUPDATER 1 \
      --set USE_BUILTIN_RIPGREP 0 \
      --prefix PATH : ${
        lib.makeBinPath (
          [
            # claude-code uses [node-tree-kill](https://github.com/pkrumins/node-tree-kill) which requires procps's pgrep(darwin) or ps(linux)
            procps
            # https://code.claude.com/docs/en/troubleshooting#search-and-discovery-issues
            ripgrep
          ]
          # the following packages are required for the sandbox to work (Linux only)
          ++ lib.optionals stdenv.hostPlatform.isLinux [
            bubblewrap
            socat
          ]
        )
      }
    runHook postInstall
  '';

  doInstallCheck = true;
  nativeInstallCheckInputs = [
    writableTmpDirAsHomeHook
    versionCheckHook
  ];
  versionCheckKeepEnvironment = [ "HOME" ];
  versionCheckProgramArg = "--version";

  meta = with lib; {
    description = "Claude Code - AI coding assistant in your terminal";
    homepage = "https://www.anthropic.com/claude-code";
    platforms = [ "x86_64-linux" ];
    mainProgram = "claude";
  };
}
