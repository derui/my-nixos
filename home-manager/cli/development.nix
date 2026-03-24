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

      # copilot CLI
      # https://github.com/NixOS/nixpkgs/issues/500198
      github-copilot-cli

      # golang
      go

      # python
      python313

      # nodejs
      nodejs_24
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
