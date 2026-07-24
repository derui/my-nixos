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

      # zig
      zig_0_15

      # python
      python313

      # nodejs
      nodejs_24

      # nix
      nixd

      # utility
      prek

      # agent
      opencode
    ]
    ++ [
      mypkgs.lsp-proxy
      mypkgs.claude-code
      mypkgs.github-copilot-cli
    ];
}
