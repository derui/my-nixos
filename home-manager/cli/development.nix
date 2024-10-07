{ pkgs, inputs, ... }:
{
  # fenixを導入しているので、これをそのまま入れる
  home.packages = with pkgs; [
    (fenix.stable.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
      "rustfmt"
    ])
    rust-analyzer-nightly
  ];
}
