# TODO gtk3に対象のpatchが含まれた状態のものがリリースされたら消す
final: prev:
{
  gtk3 = prev.gtk3.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [
      ./patches/cairo_fix.patch
    ];
  });
}
