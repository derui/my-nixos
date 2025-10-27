final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (pyfinal: pyprev: {
      maestral = pyfinal.callPackage ../../pkgs/maestral.nix { };
    })
  ];
}
