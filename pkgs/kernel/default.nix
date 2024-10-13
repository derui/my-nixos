{ pkgs, linuxKernel }:
with linuxKernel;
{
  rtl8126 = pkgs.callPackage ./rtl8126 { inherit kernel; };
}
