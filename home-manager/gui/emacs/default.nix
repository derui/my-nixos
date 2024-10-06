{ pkgs, home, ... }:
let
  # melpaにあるpackgeについて、指定したpkgについてrev/sha256をoverrideしたものを返す
  useMelpaWithFixedHash = prev: { pkg, commit, sha256 }:
    prev.melpaPackages.${pkg}.overrideAttrs (old: {
      src = pkgs.fetchFromGitHub {
        inherit (old.src) owner repo;

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
        epkgs.spacious-padding
        epkgs.perfect-margin
      ];

      # Optionally override derivations.
      override = final: prev: {
        spacious-padding =
          let
            rev = "a3151f3c99d6b3b2d4644da88546476b3d31f0fe";
            sha256 = "sha256-lDwcwuhzgWQm8ixx8R5W2XROeAJeNPktX5nsjWYIvoc=";
          in
          final.trivialBuild rec {
            pname = "spacious-padding";
            version = rev;

            src = pkgs.fetchFromGitHub {
              owner = "protesilaos";
              repo = pname;

              inherit rev sha256;
            };
          };

        magit = useMelpaWithFixedHash prev {
          pkg = "magit";
          commit = "4d054196eb1e99251012fc8b133db9512d644bf1";
          sha256 = "sha256-o7GaaOajc0EbsfXwOtHZfO6bocy5oPUlG+xwt4TGZhc=";
        };
        with-editor = useMelpaWithFixedHash prev {
          pkg = "with-editor";
          commit = "77cb2403158cfea9d8bfb8adad81b84d1d6d7c6a";
          sha256 = "sha256-+tDAxhliQJiKAZUVfX/bQbqjPEjB7p5jX7XoLf/5Bs0=";
        };
        magit-section = useMelpaWithFixedHash prev {
          pkg = "magit-section";
          commit = "4d054196eb1e99251012fc8b133db9512d644bf1";
          sha256 = "sha256-o7GaaOajc0EbsfXwOtHZfO6bocy5oPUlG+xwt4TGZhc=";
        };
        perfect-margin = useMelpaWithFixedHash prev {
          pkg = "perfect-margin";
          commit = "3281c5648d854f77450c1268dbb31f5a872900a5";
          sha256 = "sha256-RFEOvybZblO0G34xfYrwdDhcllpEAxZo3gFTSbX/74s=";
        };
      };
    })
  ];

  # Use unstable emacs
  programs.emacs.package = pkgs.emacs-git;

  home.file.".emacs.d/init.el" = {
    source = ./init.el;
  };

  home.file.".emacs.d/early-init.el" = {
    source = ./early-init.el;
  };
}
