{ pkgs, home, ... }:
let
  # melpaにあるpackgeについて、指定したpkgについてrev/sha256をoverrideしたものを返す
  useMelpa = prev: { pkg, commit, sha256 }:
    prev.melpaPackages.${pkg}.overrideAttrs (old: {
      src = pkgs.fetchFromGitHub {
        inherit (old.src) owner repo;

        rev = commit;
        inherit sha256;
      };
    });
  # melpaにあるpackgeについて、指定したpkgについてrev/sha256をoverrideしたものを返す
  useMelpaFromGitLab = prev: { pkg, commit, sha256 }:
    prev.melpaPackages.${pkg}.overrideAttrs (old: {
      src = pkgs.fetchFromGitLab {
        inherit (old.src) owner repo;

        rev = commit;
        inherit sha256;
      };
    });
  fetchFromCodeberg = { owner, repo, rev, sha256 }:
    pkgs.fetchzip {
      url = "https://codeberg.org/${owner}/${repo}/archive/${rev}.tar.gz";
      inherit sha256;
    };
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
        epkgs.f
        epkgs.ht
        epkgs.xterm-color
        epkgs.transient
        epkgs.moody
        epkgs.multistate
        epkgs.motion
        epkgs.magit-delta
        epkgs.consult
        epkgs.embark
        epkgs.embark-consult
        epkgs.marginalia
        epkgs.vertico
        epkgs.orderless
        epkgs.hotfuzz
        epkgs.corfu
        epkgs.cape
        epkgs.org
        epkgs.org-onit
        epkgs.ox-hugo
        epkgs.tomelr
        epkgs.emacsql
        epkgs.org-roam
        epkgs.org-modern
        epkgs.go-mode
        epkgs.pyvenv
        epkgs.tuareg
        epkgs.ocaml-ts-mode
        epkgs.lua-mode
        epkgs.markdown-mode
        epkgs.colorful-mode
        epkgs.yaml-pro
        epkgs.web-mode
        epkgs.add-node-modules-path
        epkgs.terraform-mode
        epkgs.hcl-mode
        epkgs.plantuml-mode
        epkgs.gtags-mode
        epkgs.protobuf-mode
        epkgs.fish-mode
        epkgs.nix-mode
        epkgs.ace-window
        epkgs.tempel
        epkgs.symbol-overlay
        epkgs.pulsar
        epkgs.imenu-list
        epkgs.which-key
        epkgs.puni
        epkgs.diff-hl
        epkgs.flymake-collection
        epkgs.posframe
        epkgs.eldoc-box
        epkgs.vundo
        epkgs.eglot-booster
        epkgs.aggressive-indent
        epkgs.copilot-mode
        epkgs.goggles
        epkgs.jinx
        epkgs.avy
        epkgs.wgrep
        epkgs.treesit-fold
        epkgs.diminish
        epkgs.nerd-icons
        epkgs.nerd-icons-completion
        epkgs.nerd-icons-dired
        epkgs.nerd-icons-corfu
        epkgs.emojify
        epkgs.exec-path-from-shell
        epkgs.ripgrep
        epkgs.mozc
        epkgs.treesit-auto
        epkgs.diredfl
        epkgs.rainbow-delimiters
        epkgs.breadcrumb
        epkgs.websocket
        epkgs.chokan
        epkgs.anzu
        epkgs.indent-bars
        epkgs.multiple-cursors
        epkgs.vterm
        epkgs.popon
        epkgs.flymake-popon
        epkgs.migemo
        epkgs.dmacro
        epkgs.tabspaces
        epkgs.dashboard
        epkgs.modus-themes
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

        magit = useMelpa prev {
          pkg = "magit";
          commit = "4d054196eb1e99251012fc8b133db9512d644bf1";
          sha256 = "sha256-o7GaaOajc0EbsfXwOtHZfO6bocy5oPUlG+xwt4TGZhc=";
        };
        with-editor = useMelpa prev {
          pkg = "with-editor";
          commit = "77cb2403158cfea9d8bfb8adad81b84d1d6d7c6a";
          sha256 = "sha256-+tDAxhliQJiKAZUVfX/bQbqjPEjB7p5jX7XoLf/5Bs0=";
        };
        magit-section = useMelpa prev {
          pkg = "magit-section";
          commit = "4d054196eb1e99251012fc8b133db9512d644bf1";
          sha256 = "sha256-o7GaaOajc0EbsfXwOtHZfO6bocy5oPUlG+xwt4TGZhc=";
        };
        perfect-margin = useMelpa prev {
          pkg = "perfect-margin";
          commit = "3281c5648d854f77450c1268dbb31f5a872900a5";
          sha256 = "sha256-RFEOvybZblO0G34xfYrwdDhcllpEAxZo3gFTSbX/74s=";
        };
        dash = useMelpa prev {
          pkg = "dash";
          commit = "1de9dcb83eacfb162b6d9a118a4770b1281bcd84";
          sha256 = "sha256-at42NCcdF9g7a55asnOCSqsvG+XhWuvVsHFT6kU9f9o=";
        };
        f = useMelpa prev {
          pkg = "f";
          commit = "1e7020dc0d4c52d3da9bd610d431cab13aa02d8c";
          sha256 = "sha256-uBVLkcVx7gQsFeF4GegDaRB3PJPTZKVhoGvLbfmT6x4=";
        };
        s = useMelpa prev {
          pkg = "s";
          commit = "dda84d38fffdaf0c9b12837b504b402af910d01d";
          sha256 = "sha256-fbF/SyPwEiJICaPBq0xWj2yLWjdNwkaLF2iYvZ2EO1k=";
        };
        gntp = useMelpa prev {
          pkg = "gntp";
          commit = "767571135e2c0985944017dc59b0be79af222ef5";
          sha256 = "sha256-fbF/SyPwEiJICaPBq0xWj2yLWjdNwkaLF2iYvZ2EO1k=";
        };
        ht = useMelpa prev {
          pkg = "ht";
          commit = "1c49aad1c820c86f7ee35bf9fff8429502f60fef";
          sha256 = "sha256-suE9ncN4rTA/9GcfAK6B+m9vnE8pYpfGavCFrXpA0+8=";
        };
        xterm-color = useMelpa prev {
          pkg = "xterm-color";
          commit = "2ad407c651e90fff2ea85d17bf074cee2c022912";
          sha256 = "sha256-mj41auz6ukrcfBcQJLzHKcZ32o2tBoLBesSRNK7Sxv8=";
        };
        transient = useMelpa prev {
          pkg = "transient";
          commit = "3430943eaa3222cd2a487d4c102ec51e10e7e3c9";
          sha256 = "sha256-4fjlEqXs+4RvDM7+s508PyWoQOHqYT+QCrasdcnZekA=";
        };
        moody = useMelpa prev {
          pkg = "moody";
          commit = "e9969fac9efd43ac7ac811a791fabaf67b536a72";
          sha256 = "sha256-US3e6/Rp4Bnw6QdgtJfBsiVBJeZfXia3T7UnigFc3UQ=";
        };
        multistate = useMelpaFromGitLab prev {
          pkg = "multistate";
          commit = "a7ab9dc7aac0b6d6d2f872de4e0d1b8550834a9b";
          sha256 = "sha256-OtlUSVoZ7YF3G/umjz/WL9RSo3PYD0TbqM4HQJAGlOQ=";
        };

        motion =
          let
            rev = "b67044122700eb02cf18223e5df7c8f8c3541131";
            sha256 = "sha256-9ovUarisxVy6qn3WloiThxfaeNGVJc2GBMdPY3Saqos=";
          in
          final.trivialBuild rec {
            pname = "motion";
            version = rev;

            src = pkgs.fetchFromGitHub {
              owner = "derui";
              repo = pname;

              inherit rev sha256;
            };
          };

        magit-delta = useMelpa prev {
          pkg = "magit-delta";
          commit = "5fc7dbddcfacfe46d3fd876172ad02a9ab6ac616";
          sha256 = "sha256-PM79aVdjjuBNgHqiu215EWdjHf6/sWunezcI31Iu8M4=";
        };

        consult = useMelpa prev {
          pkg = "consult";
          commit = "4889458dccf842ab6223099f8a73ff8b147e9459";
          sha256 = "sha256-L8M81rLgjYTDE6aYMxCMSa0LUuaATQ8RJ3ffp3ifTBo=";
        };

        embark = useMelpa prev {
          pkg = "embark";
          commit = "19a13e344e04bbf861eaa74491b23da52b398672";
          sha256 = "sha256-Oa8eJtUdhAT7w5bUL3UtyNVaLJ1z0v7/tbUIg5vJPfE=";
        };

        embark-consult = useMelpa prev {
          pkg = "embark-consult";
          commit = "19a13e344e04bbf861eaa74491b23da52b398672";
          sha256 = "sha256-Oa8eJtUdhAT7w5bUL3UtyNVaLJ1z0v7/tbUIg5vJPfE=";
        };

        marginalia = useMelpa prev {
          pkg = "marginalia";
          commit = "50a51c69f006ec8b3ba1c570555d279d4cff6d99";
          sha256 = "sha256-PRlWbxMAiZoazkQOv2LNkVcaWEoHFwAJRcztzaPKdCo=";
        };

        vertico = useMelpa prev {
          pkg = "vertico";
          commit = "c682ef50e62237435e9fc287927ce4181b49be90";
          sha256 = "sha256-+d31YIMzfJr3yJcPjMXEtlLFG2JxyF6++5UOiykscLk=";
        };

        orderless = useMelpa prev {
          pkg = "orderless";
          commit = "49d1fdfb80b55699a00b11bc916ad29c0447039b";
          sha256 = "sha256-z2YFiYgvgwQhs27f7+L0ba7iBiANHi9f+CgxUXSxKEQ=";
        };

        hotfuzz = useMelpa prev {
          pkg = "hotfuzz";
          commit = "622329477d893a9fc2528a75935cfe1f8614f4bc";
          sha256 = "sha256-RB8fanwz18sYYVF7uG2tt/fOe5EN3n7+W/XQJspAqas=";
        };

        corfu = useMelpa prev {
          pkg = "corfu";
          commit = "98026a98a6f74220fac8d79afd523454fceaa468";
          sha256 = "sha256-v6q1r3Fl1r+ktoViuF2OKuhEyHGhYRn4+3lEzhGo0Z0=";
        };

        cape = useMelpa prev {
          pkg = "cape";
          commit = "9110956a5155d5e3c460160fa1b4dac59322c229";
          sha256 = "sha256-cVvByjGcINHjNhA8I47/ELF2DhJtgZRZCf0mi4roJzc=";
        };

        org-onit =
          let
            rev = "932ed472e46c277daf1edf0efb71fbac5ff45346";
            sha256 = "sha256-zgWlR+odQLYDKpPzs+HcYwRn4+I+7kZgq3ZKpEHRM1s=";
          in
          final.trivialBuild rec {
            pname = "org-onit";
            version = rev;

            src = pkgs.fetchFromGitHub {
              owner = "takaxp";
              repo = pname;

              inherit rev sha256;
            };
          };

        ox-hugo = useMelpa prev {
          pkg = "ox-hugo";
          commit = "c4156d9d383bf97853ba9e16271b7c4d5e697f49";
          sha256 = "sha256-8HRzAk7HyAZ9TjiTHu2ekUTHiZqLVR4qyTTcu5+Eco0=";
        };

        tomelr =
          let
            rev = "670e0a08f625175fd80137cf69e799619bf8a381";
            sha256 = "sha256-0+Z2gS8VUJRfRIKGoANOofykFX1dbHLbQ89RmdWBMQ4=";
          in
          final.trivialBuild rec {
            pname = "tomelr";
            version = rev;

            src = pkgs.fetchFromGitHub {
              owner = "kaushalmodi";
              repo = pname;

              inherit rev sha256;
            };
          };

        emacsql = useMelpa prev {
          pkg = "emacsql";
          commit = "5108c16c5e1d5bfdd41fcc0807241e28886ab763";
          sha256 = "sha256-u95u/M09ju6L2MKHL5Wv5KYSO24N1CHCcFvnNUkDnGs=";
        };
        org-roam = useMelpa prev {
          pkg = "org-roam";
          commit = "0b9fcbc97b65b349826e63bad89ca121a08fd2be";
          sha256 = "sha256-tB7GqULu+XFfW03lXBV+WjPUN+8VqumMWU2Gs3TmeBM=";
        };

        org-modern = useMelpa prev {
          pkg = "org-modern";
          commit = "e306c7df4985f77e5c4e2146900259a23a76c974";
          sha256 = "sha256-FYmCZ4cednBL0653iB6Zdx7SFAEnrtER90qp57A8b38=";
        };

        go-mode = useMelpa prev {
          pkg = "go-mode";
          commit = "6f4ff9ef874d151ed8d297a80f1bf27db5d9dbf0";
          sha256 = "sha256-fyBafjaiSOGTJoMnqwsF32JGo0xD2lDDQWQ2jJG8dt0=";
        };

        pyvenv = useMelpa prev {
          pkg = "pyvenv";
          commit = "31ea715f2164dd611e7fc77b26390ef3ca93509b";
          sha256 = "sha256-ZebH6Ht9bzeIFAxeEz+s8e/Ockwzzl8+0bsfrAXsCJw=";
        };
        tuareg = useMelpa prev {
          pkg = "tuareg";
          commit = "1d53723e39f22ab4ab76d31f2b188a2879305092";
          sha256 = "sha256-W9CREajLvlZ7HVmOaJ5gjWZ31o8OdjLNyOOpJHuMThU=";
        };
        ocaml-ts-mode = useMelpa prev {
          pkg = "ocaml-ts-mode";
          commit = "bb8c86bd49e4e98f41e45fb0ec82e38f90bc3ee4";
          sha256 = "sha256-hPsRPtNms7AzmAtuMLmRVKVgWeX3NYx8JeV7DXBv1HI=";
        };
        lua-mode = useMelpa prev {
          pkg = "lua-mode";
          commit = "d074e4134b1beae9ed4c9b512af741ca0d852ba3";
          sha256 = "sha256-+yNkp/7+MGTYNvb/Rq/eLcg4Yqf4bAfTslP95HspM9g=";
        };
        markdown-mode = useMelpa prev {
          pkg = "markdown-mode";
          commit = "0cdebc833ed9b98baf9f260ed12b1e36b0ca0e89";
          sha256 = "sha256-suwVjGeWkxLTTOkrti8i8ZXjXdsD4kzOn6hQAeTcYSc=";
        };
        colorful-mode =
          let
            rev = "706472ea7f0ee2fe5719cd91df7315fe9ca86114";
            sha256 = "sha256-n99BshXxR6sqk+tATEzedVjYEPoo4wPxhvp9LiaW9jQ=";
          in
          final.trivialBuild rec {
            pname = "colorful-mode";
            version = rev;

            src = pkgs.fetchFromGitHub {
              owner = "DevelopmentCool2449";
              repo = pname;

              inherit rev sha256;
            };
          };

        yaml-pro = useMelpa prev {
          pkg = "yaml-pro";
          commit = "5f06949e92dc19dcc48dc31662b2aa958fe33726";
          sha256 = "sha256-AiYkrk2SxS9av2zxujOC4bWzmNz9MPsSMdFfYPBUzik=";
        };

        web-mode = useMelpa prev {
          pkg = "web-mode";
          commit = "005aa62d6f41fbf9bc045cac3b3b772716ee8ba7";
          sha256 = "sha256-6FJRd2wtjcFUk1hsm75o+WOHea3WSlAFe07vy1tCbZU=";
        };
        add-node-modules-path = useMelpa prev {
          pkg = "add-node-modules-path";
          commit = "841e93dfed50448da66c89a977c9182bb18796a1";
          sha256 = "sha256-3izsgr/uy+uGwkjLD9eVF/QT23XcVsZp+eEij5rshVE=";
        };
        terraform-mode = useMelpa prev {
          pkg = "terraform-mode";
          commit = "a645c32a8f0f0d04034262ae5fea330d5c7a33c6";
          sha256 = "sha256-2Zmyw83hbGvqmcDVabNVS9I9CbfcE06YHWNIBJsi658=";
        };
        hcl-mode = useMelpa prev {
          pkg = "hcl-mode";
          commit = "37f2cb1bf6fb51fbf99d4fac256298fcd6d1dd24";
          sha256 = "sha256-/8g9LJbPOeIuNor/jFV/h+3fwu7baj7UBgmSwR0JvPM=";
        };
        plantuml-mode = useMelpa prev {
          pkg = "plantuml-mode";
          commit = "ea45a13707abd2a70df183f1aec6447197fc9ccc";
          sha256 = "sha256-nSdKlSz8Ua9Vf0f3IcJIRj7v7f2tCIqNrjNxYpKwdWU=";
        };

        gtags-mode =
          let
            rev = "2f553d0c41c470c5d2ee4210267161333969e080";
            sha256 = "sha256-nU2G62xfjIcMA/OscRy8jyzlkll0mKyp713eB9MwWYs=";
          in
          final.trivialBuild rec {
            pname = "gtags-mode";
            version = rev;

            src = pkgs.fetchFromGitHub {
              owner = "Ergus";
              repo = pname;

              inherit rev sha256;
            };
          };

        protobuf-mode = useMelpa prev {
          pkg = "protobuf-mode";
          commit = "54d8f03974c108ef8fd0f26568cd9eb086165568";
          sha256 = "sha256-g4ds8zvO6AeZZ9E30n8MoVl93s0XySCmuJRB3ccspZU=";
        };

        fish-mode = useMelpa prev {
          pkg = "fish-mode";
          commit = "2526b1803b58cf145bc70ff6ce2adb3f6c246f89";
          sha256 = "sha256-hkBKYCP3plY4zdBPqx0Ucfu3D+cEmBtgWHSXT+ckTtg=";
        };
        nix-mode = useMelpa prev {
          pkg = "nix-mode";
          commit = "719feb7868fb567ecfe5578f6119892c771ac5e5";
          sha256 = "sha256-W/bxCAn4cvzKGbhILxtTiWJ5Wln2w6g4TPgk+ziCXsQ=";
        };
        ace-window = useMelpa prev {
          pkg = "ace-window";
          commit = "77115afc1b0b9f633084cf7479c767988106c196";
          sha256 = "sha256-eGmOL272H5X7BmeXRCfMjB3ucf9GH2xThyozgkW62dA=";
        };
        tempel = useMelpa prev {
          pkg = "tempel";
          commit = "317c0e41d542721db11a7a8a1c6b78762959259b";
          sha256 = "sha256-GQbpXkYDY+dmaEtZlIU7aghksUbpcqOyqZhiNnMq2Ps=";
        };
        symbol-overlay = useMelpa prev {
          pkg = "symbol-overlay";
          commit = "de215fff392c916ffab01950fcb6daf6fd18be4f";
          sha256 = "sha256-zYDTPtpazslqebWDURKmw2TRcfptmo+fUNelMKAAgVg=";
        };
        pulsar =
          let
            rev = "f20879ee38121a30498b25bc3d0b07460227b63a";
            sha256 = "sha256-o6jrTU3zY2GVlZpilGCK+cpUThfbrm5XF+2vE1VEKWg=";
          in
          final.trivialBuild rec {
            pname = "pulsar";
            version = rev;

            src = pkgs.fetchFromGitHub {
              owner = "protesilaos";
              repo = pname;

              inherit rev sha256;
            };
          };

        which-key = useMelpa prev {
          pkg = "which-key";
          commit = "1e89fa000e9ba9549f15ef57abccd118d5f2fe1a";
          sha256 = "sha256-wR3JYmO8jp4dlxKQAAhUr0OUXG74HqgEGPC/tvJz5QU=";
        };

        puni = useMelpa prev {
          pkg = "puni";
          commit = "72e091ef30e0c9299dbcd0bc4669ab9bb8fb6e47";
          sha256 = "sha256-svSbr8DgJttn6lyhcSZgUHFekP0YE4Sj/LZNxa3JQts=";
        };

        diff-hl = useMelpa prev {
          pkg = "diff-hl";
          commit = "b80ff9b4a772f7ea000e86fbf88175104ddf9557";
          sha256 = "sha256-XFvJcO2LvNa2ebtbjOB0Zjg6LmF+OYSOhdnT4T702G0=";
        };

        flymake-collection = useMelpa prev {
          pkg = "flymake-collection";
          commit = "ecc15c74630fa75e7792aa23cec79ea4afc28cc2";
          sha256 = "sha256-G28EURg7YQtgZWjMzenBggsT8L+jnQrSqeqZZhOVGLs=";
        };

        posframe = useMelpa prev {
          pkg = "posframe";
          commit = "570273bcf6c21641f02ccfcc9478607728f0a2a2";
          sha256 = "sha256-4/gK1VGhaF8l0ymUStY30TUlRY8OHOykFTpY1IF3M9w=";
        };
        eldoc-box = useMelpa prev {
          pkg = "eldoc-box";
          commit = "d3250fccf26649f250e8678f22276f375c01aec5";
          sha256 = "sha256-gGxEbkDXP2Nl4KjuqRZY/DeTXTFO+gyjV+YsXb+LYWE=";
        };

        vundo =
          let
            rev = "ca590c571546eb1d38c855216db11d28135892f2";
            sha256 = "sha256-2CTtDGXB9puk/MK1PId0zJllK2vHSw728Wbft3dfEak=";
          in
          final.trivialBuild rec {
            pname = "vundo";
            version = rev;

            src = pkgs.fetchFromGitHub {
              owner = "casouri";
              repo = pname;

              inherit rev sha256;
            };
          };

        eglot-booster =
          let
            rev = "e19dd7ea81bada84c66e8bdd121408d9c0761fe6";
            sha256 = "sha256-vF34ZoUUj8RENyH9OeKGSPk34G6KXZhEZozQKEcRNhs=";
          in
          final.trivialBuild rec {
            pname = "eglot-booster";
            version = rev;

            src = pkgs.fetchFromGitHub {
              owner = "jdtsmith";
              repo = pname;

              inherit rev sha256;
            };
          };

        copilot-mode =
          let
            rev = "535ef61e82f09d744cd5b097b1fc99f08cce175c";
            sha256 = "sha256-/ZDnEZWUFcKnUtFrd/4C7LX16GAdUQncU8ZnYzntKS0=";
          in
          final.trivialBuild rec {
            pname = "copilot.el";
            version = rev;

            packageRequires = [ prev.f prev.dash ];
            src = pkgs.fetchFromGitHub {
              owner = "copilot-emacs";
              repo = pname;

              inherit rev sha256;
            };

            files = [ "dist" "*.el" ];
          };

        goggles = useMelpa prev {
          pkg = "goggles";
          commit = "41d3669d7ae7b73bd39d298e5373ece48b656ce3";
          sha256 = "sha256-5KOpw/iOyz0Dxzwkiw/L53BOaU5kMq45rY6u8J7vn7k=";
        };
        jinx = useMelpa prev {
          pkg = "jinx";
          commit = "cd827ee199efedc8f5e094001d90206e698f91e";
          sha256 = "sha256-s6DQ9UlQ98071n+nbhcRU2J2qgNosiJxqC4FTazwkww=";
        };

        wgrep = useMelpa prev {
          pkg = "wgrep";
          commit = "208b9d01cfffa71037527e3a324684b3ce45ddc4";
          sha256 = "sha256-82cK3D1JZXr0XIx4P8HiWwfsQMttvqBNHHD9bC60Cmw=";
        };

        treesit-fold =
          let
            rev = "7312871386e4b525a0ced6a03dc33062cb27f573";
            sha256 = "sha256-/RtT8Fg+wb5+uakmUSRxNtv9paAM6VgqeqJUSHp0S8c=";
          in
          final.trivialBuild rec {
            pname = "treesit-fold";
            version = rev;

            src = pkgs.fetchFromGitHub {
              owner = "emacs-tree-sitter";
              repo = pname;

              inherit rev sha256;
            };
          };

        nerd-icons = useMelpa prev {
          pkg = "nerd-icons";
          commit = "c3d641d8e14bd11b5f98372da34ee5313636e363";
          sha256 = "sha256-jloY9C1XT8RVHJmua2B0V6u6x8NMBxNQLCbMjXoAsTY=";
        };
        nerd-icons-completion = useMelpa prev {
          pkg = "nerd-icons-completion";
          commit = "426a1d7c29a04ae8e6ae9b55b0559f11a1e8b420";
          sha256 = "sha256-VSPgyT1c/KSjcWjqt1C+BOvNHzgM92SYCxuNnVj3cw4=";
        };
        nerd-icons-dired = useMelpa prev {
          pkg = "nerd-icons-dired";
          commit = "c1c73488630cc1d19ce1677359f614122ae4c1b9";
          sha256 = "sha256-Am/vr2AXGbr6UQYCxpEoOJFeW+aRZ7UpoZANdmIcx9I=";
        };
        nerd-icons-corfu = useMelpa prev {
          pkg = "nerd-icons-corfu";
          commit = "7077bb76fefc15aed967476406a19dc5c2500b3c";
          sha256 = "sha256-Z1kdiEhU9F688vEyqRqfy7YxXUJ8zXu4NKp+QcQEoo4=";
        };
        exec-path-from-shell = useMelpa prev {
          pkg = "exec-path-from-shell";
          commit = "72ede29a0e0467b3b433e8edbee3c79bab005884";
          sha256 = "sha256-MGZRnOvMT9H3nmM2DUcLaJBnZ/vh6EqqX7D1st3mkpU=";
        };
        treesit-auto = useMelpa prev {
          pkg = "treesit-auto";
          commit = "016bd286a1ba4628f833a626f8b9d497882ecdf3";
          sha256 = "sha256-pA6BWV1Uc4yRh5eKevhbGuKGzbFliAZbJBf3y05Vew0=";
        };
        diredfl = useMelpa prev {
          pkg = "diredfl";
          commit = "f6d599c30875ab4894c1deab9713ff2faea54e06";
          sha256 = "sha256-950lJoUYnRdWMfVjPwlZuX1fjcY07tOyH78vWwWy8ok=";
        };

        breadcrumb =
          let
            rev = "dcb6e2e82de2432d8eb75be74c8d6215fc97a2d3";
            sha256 = "sha256-toWIJ/rlKNsAxH/LLZRF084nQ5gfCJYWbB+9pJN8YgY=";
          in
          final.trivialBuild rec {
            pname = "breadcrumb";
            version = rev;

            src = pkgs.fetchFromGitHub {
              owner = "joaotavora";
              repo = pname;

              inherit rev sha256;
            };
          };

        websocket = useMelpa prev {
          pkg = "websocket";
          commit = "40c208eaab99999d7c1e4bea883648da24c03be3";
          sha256 = "sha256-pN3gTdVH5IWUq0eGvkXBgkUcxzni2Iq24ZrHnIfxAC8=";
        };
        chokan =
          let
            rev = "206acbfdc9709fa0392c4ad97cc263394db4ac1a";
            sha256 = "sha256-Z8ClZdmgQ7muoay3xuHa+CQbdzaNtGJDQ/Oi+2m86Mw=";
          in
          final.trivialBuild rec {
            pname = "chokan";
            version = rev;

            packageRequires = [ prev.websocket ];
            src = pkgs.fetchFromGitHub {
              owner = "derui";
              repo = pname;

              inherit rev sha256;
            };
          };

        anzu = useMelpa prev {
          pkg = "anzu";
          commit = "bc3a0032bb6aa7f5886f10460cd53eb7b8b020af";
          sha256 = "sha256-KIH3pKHDk76HoMZwFjVnzESiDXCo1XR9AVVU8HkBI+I=";
        };

        indent-bars =
          let
            rev = "2d1d854ddaa5b0e19b69e73553675c2aaaed1641";
            sha256 = "sha256-gcqFMjgWktfGFKeiW6uwWbBtEM1Om2ezMI7W/ZGUFkE=";
          in
          final.trivialBuild rec {
            pname = "indent-bars";
            version = rev;

            src = pkgs.fetchFromGitHub {
              owner = "jdtsmith";
              repo = pname;

              inherit rev sha256;
            };
          };

        multiple-cursors = useMelpa prev {
          pkg = "multiple-cursors";
          commit = "c870c18462461df19382ecd2f9374c8b902cd804";
          sha256 = "sha256-SsNtYGQHMKFZEWerZMfqEUH137diS0APlJtWMIFiA5w=";
        };
        vterm = useMelpa prev {
          pkg = "vterm";
          commit = "988279316fc89e6d78947b48513f248597ba969a";
          sha256 = "sha256-W/UGA3/ecu1fd7u5pYTlRqcULF3EgCVnWQGQYX93YOI=";
        };
        popon =
          let
            rev = "bf8174cb7e6e8fe0fe91afe6b01b6562c4dc39da";
            sha256 = "sha256-stiwCre9Ih6GwKjVQ7iFmMPGbkiQHx8hNgy8PHRE1BA=";
          in
          final.trivialBuild rec {
            pname = "emacs-popon";
            version = rev;

            src = fetchFromCodeberg {
              owner = "akib";
              repo = pname;

              inherit rev sha256;
            };
          };
        flymake-popon =
          let
            rev = "99ea813346f3edef7220d8f4faeed2ec69af6060";
            sha256 = "sha256-YUyCP3WIjOAvaTP6d2G68mqwGwWdRqhoFMaJWai1WFI=";
          in
          final.trivialBuild rec {
            pname = "emacs-flymake-popon";
            version = rev;

            packageRequires = [ prev.popon prev.posframe ];
            src = fetchFromCodeberg {
              owner = "akib";
              repo = pname;

              inherit rev sha256;
            };
          };
        tabspaces = useMelpa prev {
          pkg = "tabspaces";
          commit = "c21f28b96b63926a530babe50d2c4de81ebaaa18";
          sha256 = "sha256-HppqgqnDQ2XTH8M/IcZYcKl1q4RA+jUvwuyodwGEtV8=";
        };
        dashboard = useMelpa prev {
          pkg = "dashboard";
          commit = "3852301f9c6f3104d9cc98389612b5ef3452a7de";
          sha256 = "sha256-mxTDALb8RqZWeKS08LI1/mtJcNFpOndUSee/2nxwHaU=";
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
