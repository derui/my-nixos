{ pkgs, inputs, ... }:
{
  # fenixを導入しているので、これをそのまま入れる
  home.packages = with pkgs; [
    # common
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
