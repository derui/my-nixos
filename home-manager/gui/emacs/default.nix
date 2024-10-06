{ pkgs, home, ... }:
{
  # lspを高速化するための拡張
  home.packages = with pkgs; [ emacs-lsp-booster ];

  programs.emacs = {
    enable = true;
  };
}
