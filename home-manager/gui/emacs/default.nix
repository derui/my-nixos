{ pkgs, home, ... }:
{
  # lspを高速化するための拡張
  home.packages = with pkgs; [
    emacs-lsp-booster

    (pkgs.emacsWithPackagesFromUsePackage {
      # configはinit.elとinit.orgで管理するので、ここでは設定しない
      config = ./init.el;

      #  default.elは用意しない
      defaultInitFile = false;

      # Package is optional, defaults to pkgs.emacs
      package = pkgs.emacs-git;

      extraEmacsPackages = epkgs: [
        # treesitのgrammerは全体を用意しておく
        epkgs.treesit-grammars.with-all-grammars
      ];

      # Optionally override derivations.
      override = final: prev: {
        magit =
          let
            rev = "4d054196eb1e99251012fc8b133db9512d644bf1";
            sha256 = "sha256-SEqDeF5F/DQ5/NOi3n6mYhlkYg+VxY/EPAvxtt5wUG0=";
          in
          prev.melpaPackages.magit.overrideAttrs (old:
            {
              src = pkgs.fetchFromGitHub {
                owner = old.src.owner;
                repo = old.src.repo;

                inherit
                  rev
                  sha256;
              };
            });
      };
    })
  ];

  # Use unstable emacs
  programs.emacs.package = pkgs.emacs-git;
}
