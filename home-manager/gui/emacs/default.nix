{ inputs, pkgs, ... }:
let
  my-dot-emacs = pkgs.fetchgit {
    url = "https://github.com/derui/dot.emacs.d";
    rev = "e5f7f2d7809cbebef48fd18caf8f917ab61972e9";
    hash = "sha256-zSHmBuRmaZFgwV36gIkVFusmWiOBEJeJm8TMd11g3Jg=";
  };
in
{
  home.packages = with pkgs; [
    # lspを高速化するための拡張
    emacs-lsp-booster
  ];

  # Use unstable emacs
  programs.emacs.package = pkgs.emacs-git;

  # installはgitのcheckoutをそのまま設定することで確立する。
  xdg.configFile = {
    "emacs/".source = my-dot-emacs;
  };

}
