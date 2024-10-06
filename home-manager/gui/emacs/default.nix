{ pkgs, home, epkgs, ... }:
{
  # lspを高速化するための拡張
  home.packages = with pkgs; [ emacs-lsp-booster ];

  programs.emacs = {
    # enableするとstableのが入ってくるので、home.packageに任せる
    extraPackages = (epkgs: with epkgs; [
      magit
    ]);

    overrides = self: super: rec {
      magit = self.melpaPackages.magit.override (args: {
        melpaBuild = drv: args.melpaBuild (drv // {
          commit = "4d054196eb1e99251012fc8b133db9512d644bf1";
        });

      });
    };
  };
}
