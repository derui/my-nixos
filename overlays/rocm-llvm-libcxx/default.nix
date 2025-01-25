# TODO https://github.com/NixOS/nixpkgs/pull/375850 がunstableにmergeされたら消す
final: prev: {
  rocmPackages = prev.rocmPackages // {
    llvm = prev.rocmPackages.llvm // {
      libcxx = prev.rocmPackages.llvm.libcxx.overrideDerivation (oldAttrs: {
        # Most of these can't find `bash` or `mkdir`, might just be hard-coded paths, or PATH is altered
        postPatch = ''
          ${oldAttrs.postPatch}
          cat ${./1000-libcxx-failing-tests.list} | xargs -d \\n rm
        '';
      });
    };
  };
}
