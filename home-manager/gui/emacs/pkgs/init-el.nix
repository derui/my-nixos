# init.elをbuildするためのpackage
{ stdenv, emacs }:
stdenv.mkDerivation {
  name = "emacs-init-el";
  src = ../files;

  # emacsは引数に渡されたものを利用する
  buildInputs = [ emacs ];

  # ob-tangleで展開する
  buildPhase = ''
        emacs -Q --batch --eval \
          "
    (progn
      (setq debug-on-error t)
      (setq vc-handled-backends nil)
      (require 'ob-tangle)
      (org-babel-tangle-file \"./early-init.org\" \"./early-init.el\" \"emacs-lisp\")
      (org-babel-tangle-file \"./init.org\" \"./init.el\" \"emacs-lisp\")
      (byte-compile-file \"./early-init.el\"))
    "
  '';

  # share/emacsとしてインストールする
  installPhase = ''
    mkdir -p $out/share/emacs
    cp ./init.el $out/share/emacs/init.el
    cp ./early-init.el $out/share/emacs/early-init.el
  '';
}
