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

      # git alternative
      jujutsu

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
      prek
    ]
    ++ [
      mypkgs.lsp-proxy
      mypkgs.claude-code
    ];
}
