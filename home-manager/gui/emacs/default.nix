{ inputs, pkgs, ... }:
let
  my-dot-emacs = builtins.fetchGit {
    url = "https://github.com/derui/dot.emacs.d";
    rev = "9b7f5eb8dfc8c191994cfcb8cd7b32f3afff2d57";
  };
  treesit = (pkgs.emacsPackagesFor pkgs.emacs-git).treesit-grammars.with-all-grammars;
in
{
  home.packages = with pkgs; [
    pkgs.emacs-pgtk
    # lspを高速化するための拡張
    emacs-lsp-booster
  ];

  # Use unstable emacs
  programs.emacs.package = pkgs.emacs-pgtk;

  # installはgitのcheckoutをそのまま設定することで確立する。
  xdg.configFile = {
    # use treesit on lib
    "emacs-local/tree-sitter".source = "${treesit}/lib";
    # load emacs from original place
    "emacs/".source = my-dot-emacs;
    "emacs-local/templates".source = "${my-dot-emacs}/templates";
  };

}
