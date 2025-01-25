# TODO https://github.com/NixOS/nixpkgs/pull/376823 が来たら削除する
final: prev: {
  ardour = prev.ardour.overrideAttrs (old: {
    wafConfigureFlags = (final.lib.lists.remove "--cxx11" (old.wafConfigureFlags or [ ])) ++ [
      "--cxx17"
    ];
  });
}
