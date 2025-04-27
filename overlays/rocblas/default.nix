# TODO tensile自体のコンパイルを通すために無理やりoverrideしている。
final: prev: {
  rocmPackages =
    prev.rocmPackages
    // (
      let
        tensile = prev.rocmPackages.tensile.overrideAttrs (
          finalAttrs: previousAttrs: {
            # こういう置き換えなのは、もともとのstdenvによる。
            setupHook = prev.writeText "setup-hook" ''
              export TENSILE_ROCM_ASSEMBLER_PATH="${prev.rocmPackages.llvm.rocmClangStdenv.cc.cc}/bin/clang++";
            '';
          }
        );

        rocblas = prev.rocmPackages.rocblas.override { tensile = tensile; };
        rocsolver = prev.rocmPackages.rocsolver.override { rocblas = rocblas; };

      in
      {
        inherit rocblas rocsolver tensile;

        hipblas = prev.rocmPackages.hipblas.override {
          rocblas = rocblas;
          rocsolver = rocsolver;
        };
      }
    );

}
