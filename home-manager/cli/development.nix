{ pkgs, inputs, ... }:
{
  # fenixを導入しているので、これをそのまま入れる
  home.packages = with pkgs: [
    (fenix.complete.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
      "rustfmt"
    ])
    rust-analyzere-nightly
  ];
    }
