{ pkgs, home, ... }:
let
  # melpaにあるpackgeについて、指定したpkgについてrev/sha256をoverrideしたものを返す
  useMelpaWithFixedHash = prev: { pkg, commit, sha256 }:
    prev.melpaPackages.${pkg}.overrideAttrs (old: {
      src = pkgs.fetchFromGitHub {
        owner = old.src.owner;
        repo = old.src.repo;

        rev = commit;
        inherit sha256;
      };
    });
in
{
  # lspを高速化するための拡張
  home.packages = with pkgs; [
    emacs-lsp-booster

    (pkgs.emacsWithPackagesFromUsePackage {
      # configはinit.elとinit.orgで管理するので、ここでは設定しない
      config = "";

      #  default.elは用意しない
      defaultInitFile = false;

      # Package is optional, defaults to pkgs.emacs
      package = pkgs.emacs-git;

      extraEmacsPackages = epkgs: [
        # treesitのgrammerは全体を用意しておく
        epkgs.treesit-grammars.with-all-grammars
        epkgs.magit
      ];

      # Optionally override derivations.
      override = final: prev: {
        magit = useMelpaWithFixedHash prev {
          pkg = "magit";
          commit = "4d054196eb1e99251012fc8b133db9512d644bf1";
          sha256 = "sha256-o7GaaOajc0EbsfXwOtHZfO6bocy5oPUlG+xwt4TGZhc=";
        };
      };
    })
  ];

  # Use unstable emacs
  programs.emacs.package = pkgs.emacs-git;
}
