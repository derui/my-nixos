{ inputs, pkgs, ... }:
let
  my-dot-emacs = builtins.fetchGit {
    url = "https://github.com/derui/dot.emacs.d";
    rev = "d43205a55715e3347abc114d907467ebb124d022";
  };
  treesit = (pkgs.emacsPackagesFor pkgs.emacs-git).treesit-grammars.with-all-grammars;
in
{
  home.packages = with pkgs; [
    pkgs.emacs-git-pgtk
    # lspを高速化するための拡張
    emacs-lsp-booster
  ];

  # Use unstable emacs
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
