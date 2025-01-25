# TODO https://github.com/NixOS/nixpkgs/pull/375850 がunstableにmergeされたら消す
final: prev: {
  rocmPackages.llvm.libcxx = prev.rocmPackages.llvm.libcxx.overrideAttrs (old: {
    # Most of these can't find `bash` or `mkdir`, might just be hard-coded paths, or PATH is altered
    extraPostPatch = ''
      chmod +w -R ../libcxx/test/{libcxx,std}
      cat ${./1000-libcxx-failing-tests.list} | xargs -d \\n rm
    '';
  });
}
