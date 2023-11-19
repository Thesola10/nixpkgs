{
  callPackage,
  lib,
  haskell,
  haskellPackages,
}:

let
  hsPkg = haskellPackages.changelog-d;

  haskellModifications = haskell.lib.justStaticExecutables;

  mkDerivationOverrides = finalAttrs: oldAttrs: {

    version = oldAttrs.version + "-git-${lib.strings.substring 0 7 oldAttrs.src.rev}";

    passthru.updateScript = lib.getExe (callPackage ./updateScript.nix { });
    passthru.tests = {
      basic = callPackage ./tests/basic.nix { changelog-d = finalAttrs.finalPackage; };
    };

    meta = oldAttrs.meta // {
      homepage = "https://codeberg.org/fgaz/changelog-d";
      maintainers = [ lib.maintainers.roberth ];
    };

  };
in
  (haskellModifications hsPkg).overrideAttrs mkDerivationOverrides
