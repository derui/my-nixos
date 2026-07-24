{
  inputs,
  pkgs,
  lib,
  ...
}:
let
  my-dot-emacs = fetchGit {
    url = "https://github.com/derui/dot.emacs.d";
    rev = "54adc02fb1441e44e12908f1564b640b578e182b";
  };

  # temporary avoid broken parser
  treesit = (pkgs.emacsPackagesFor pkgs.emacs-git-pgtk).treesit-grammars.with-grammars (
    p:
    # `p` is attribute of package, treesit-grammars. filterAttrs filter `attributes`, but it a set.
    # with-grammars requires a list of packages, so use attrValues to convert it.
    builtins.attrValues (lib.filterAttrs (_: g: !(g.meta.broken or false)) p)
  );

  emacs = pkgs.emacs-git-pgtk;
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
