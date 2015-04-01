{ cabal, cabalInstall, esqueleto, persistent, persistentTemplate, persistentPostgresql, snap, snapCore }:

cabal.mkDerivation (self: {
  pname = "snap-postgresql";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  buildTools = [ cabalInstall ];
  buildDepends = [esqueleto persistent persistentTemplate persistentPostgresql snap snapCore];
  meta = {
    platforms = self.ghc.meta.platforms;
  };
})
