# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, executablePath, mtl, QuickCheck, statePlus }:

cabal.mkDerivation (self: {
  pname = "test-simple";
  version = "0.1.7";
  sha256 = "1p9y15vv23j1qn3shxl2wqb8skh0n53vrb39qv1nvff9bclxldka";
  buildDepends = [ mtl QuickCheck statePlus ];
  testDepends = [ executablePath mtl QuickCheck ];
  meta = {
    description = "Simple Perl inspired testing";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
  };
})
