{ pkgs, inputs, ... }:
let
  mypkgs = inputs.self.outputs.packages.${pkgs.system};
in
{
  # fenixを導入しているので、これをそのまま入れる
  home.packages = with pkgs; [
    # common
    git
    delta
    ghq

    # Rust
    (fenix.stable.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
      "rustfmt"
    ])
    rust-analyzer-nightly

    # python
    python312

    # nodejs
    nodejs-slim_22
    nodePackages.pnpm

    # nix
    nixd

    # utility
    pre-commit

  ];
}
