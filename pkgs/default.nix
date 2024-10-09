# pkgs: (pkgs.callPackage ./noto-fonts.nix {})
pkgs: {
  noto-fonts = pkgs.callPackage ./noto-fonts.nix { };
  noto-fonts-cjk-sans = pkgs.callPackage ./noto-fonts-cjk-sans.nix { };
  noto-fonts-cjk-serif = pkgs.callPackage ./noto-fonts-cjk-serif.nix { };
  udev-gothic = pkgs.callPackage ./udev-gothic.nix { };
  udev-gothic-nf = pkgs.callPackage ./udev-gothic-nf.nix { };
  moralerspace-nf = pkgs.callPackage ./moralerspace-nf.nix { };
}
