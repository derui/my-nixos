{
  inputs,
  pkgs,
  lib,
  ...
}:
let
  my-dot-emacs = fetchGit {
    url = "https://github.com/derui/dot.emacs.d";
    rev = "3d4dd1a65c93ca9c307941e8ae98f0f6be32fb8f";
  };

  # temporary avoid broken parser
  treesit = (pkgs.emacsPackagesFor pkgs.emacs-git).treesit-grammars.with-grammars (
    p:
    # `p` is attribute of package, treesit-grammars. filterAttrs filter `attributes`, but it a set.
    # with-grammars requires a list of packages, so use attrValues to convert it.
    builtins.attrValues (lib.filterAttrs (_: g: !(g.meta.broken or false)) p)
  );

  emacs = pkgs.emacs-git.overrideAttrs (
    _:
    let
      libGccJitLibraryPaths = [
        "${lib.getLib pkgs.libgccjit}/lib/gcc"
        "${lib.getLib pkgs.stdenv.cc.libc}/lib"
      ]
      ++ lib.optionals (pkgs.stdenv.cc ? cc.lib.libgcc) [
        "${lib.getLib pkgs.stdenv.cc.cc.lib.libgcc}/lib"
      ];
    in
    {
      # remove original patches and leave only nativecomp-related patch
      patches = [
        (pkgs.replaceVars ./native-comp-driver-options-30.patch {
          backendPath = (
            lib.concatStringsSep " " (
              map (x: ''"-B${x}"'') (
                [
                  # Paths necessary so the JIT compiler finds its libraries:
                  "${lib.getLib pkgs.libgccjit}/lib"
                ]
                ++ libGccJitLibraryPaths
                ++ [
                  # Executable paths necessary for compilation (ld, as):
                  "${lib.getBin pkgs.stdenv.cc.cc}/bin"
                  "${lib.getBin pkgs.stdenv.cc.bintools}/bin"
                  "${lib.getBin pkgs.stdenv.cc.bintools.bintools}/bin"
                ]
              )
            )
          );
        })
      ];
    }
  );
in
{
  home.packages = with pkgs; [
    emacs
    # lspを高速化するための拡張
    emacs-lsp-booster

    # jinx
    gcc
    pkg-config
    cmake
    glibc
  ];
  # headerとかをinstallするための設定
  home.extraOutputsToInstall = [
    "dev"
    "lib"
  ];

  # Use git emacs
  programs.emacs.package = pkgs.emacs-git-pgtk;

  # installはgitのcheckoutをそのまま設定することで確立する。
  xdg.configFile = {
    # use treesit on lib
    "emacs-local/tree-sitter".source = "${treesit}/lib";
    # load emacs from original place
    "emacs/".source = my-dot-emacs;
    "emacs-local/templates".source = "${my-dot-emacs}/templates";
  };
}
