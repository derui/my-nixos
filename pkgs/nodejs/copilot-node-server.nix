{ buildNpmPackage, fetchFromGitHub, ... }:
let
  pname = "copilot-node-server";
  # 2024/10時点だと1.27.0じゃないとcopilot.elが対応していない。
  version = "1.27.0";
in
buildNpmPackage {
  inherit pname version;

  src = fetchFromGitHub {
    owner = "jfcherng";
    repo = pname;
    rev = "${version}";
    hash = "sha256-Ds2agoO7LBXI2M1dwvifQyYJ3F9fm9eV2Kmm7WITgyo=";
  };


  # 単にagent.jsをいれるためだけのpackageなので、buildや依存はない。
  dontNpmBuild = true;
  dontNpmInstall = true;
  npmDepsHash = "sha256-HyagGBj7iCP4Bqa3vFxZ0WsFGvP4+JIO68T76FGnh+4=";
  # 依存がないのでempty cacheにしないといけない
  forceEmptyCache = true;
  postPatch = ''
    cp ${./copilot-node-server-package-lock.json} package-lock.json
  '';

  installPhase = ''
    mkdir -p $out/node_modules/${pname}
    cp -r $src/copilot $out/node_modules/${pname}/copilot
    cp ./package.json $out/node_modules/${pname}/
  '';

  meta = {
    description = "Copilot Node.js server stripped from copilot.vim and published on NPM.";
    homepage = "https://github.com/jfcherng/copilot-node-server.git";
  };
}
