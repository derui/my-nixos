{
  inputs,
  pkgs,
  lib,
  ...
}:
let
  my-dot-emacs = fetchGit {
    url = "https://github.com/derui/dot.emacs.d";
    rev = "3deaa7ca0fe1864abda3ca1fbd7ba67749899d81";
  };

  # temporary avoid broken parser
  treesit = (pkgs.emacsPackagesFor pkgs.emacs-git).treesit-grammars.with-grammars (
    p:
    # `p` is attribute of package, treesit-grammars. filterAttrs filter `attributes`, but it a set.
    # with-grammars requires a list of packages, so use attrValues to convert it.
    builtins.attrValues (lib.filterAttrs (_: g: !(g.meta.broken or false)) p)
  );
in
{
  home.packages = with pkgs; [
    pkgs.emacs-git-pgtk
    # lspを高速化するための拡張
    emacs-lsp-booster

    # jinx
    gcc
    pkg-config
    cmake
    libvterm
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
