{ pkgs, inputs, ... }:
let
  mypkgs = inputs.self.outputs.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  # fenixを導入しているので、これをそのまま入れる
  home.packages =
    with pkgs;
    [
      # common
      git
      delta
      ghq

      # podman
      podman-compose

      # Rust
      (fenix.stable.withComponents [
        "cargo"
        "clippy"
        "rust-src"
        "rustc"
        "rustfmt"
      ])
      rust-analyzer-nightly

      # golang
      go

      # python
      python312

      # nodejs
      nodejs_22
      nodePackages.pnpm

      # nix
      nixd

      # utility
      pre-commit
    ]
    ++ [ mypkgs.lsp-proxy ];
}
