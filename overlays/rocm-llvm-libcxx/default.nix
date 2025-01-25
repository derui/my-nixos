# TODO https://github.com/NixOS/nixpkgs/pull/375850 がunstableにmergeされたら消す
final: prev: {
  rocmPackages = prev.rocmPackages // {
    llvm = prev.rocmPackages.llvm // {
      libcxx = prev.rocmPackages.llvm.libcxx.overrideAttrs (
        { targetDir }:
        {
          # Most of these can't find `bash` or `mkdir`, might just be hard-coded paths, or PATH is altered
          postPatch = ''
            cd ${targetDir}

            patchShebangs lib/OffloadArch/make_generated_offload_arch_h.sh

            # FileSystem permissions tests fail with various special bits
            rm test/tools/llvm-objcopy/ELF/mirror-permissions-unix.test
            rm unittests/Support/Path.cpp

            substituteInPlace unittests/Support/CMakeLists.txt \
              --replace-fail "Path.cpp" ""
                chmod +w -R ../libcxx/test/{libcxx,std}
                cat ${./1000-libcxx-failing-tests.list} | xargs -d \\n rm
          '';
        }
      );
    };
  };
}
