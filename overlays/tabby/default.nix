# TODO tabbyにvulkan supportが入ったら消す
final: prev: {
  tabby = prev.callPackage ./package.nix { };
}
