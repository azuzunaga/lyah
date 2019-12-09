{ ghcVersion ? "ghc864"
, nixpkgs ? import ./nixpkgs.nix
}:
let
  inherit (nixpkgs) pkgs;
  inherit (pkgs) stdenv callPackage lib;
  inherit (pkgs) texlive;

  appRoot = builtins.toPath ./.;
  pname = "bla";
  version = "0.1.0";

  hiePkgs = import (builtins.fetchGit {
    url = https://github.com/Infinisil/all-hies.git;
    ref = "master";
    rev = "8d9b0e770c8e2264ef4882623a205548d9fdaa03";
  }) { };

  haskellPkgs = pkgs.haskell.packages."${ghcVersion}".extend(self: super: {
    lyah = super.callPackage ./package.nix {};
    Diff = pkgs.haskell.lib.dontCheck super.Diff;
  });

  texliveEnv = texlive.combine {
    inherit (texlive)
              beamer beamertheme-metropolis pgf pgfopts pdfpages pdftools
              listings collection-fontsrecommended collection-mathscience
              collection-xetex fancyvrb fontspec caption tikz-cd fira
              etoolbox trimspaces environ ulem capt-of wrapfig tcolorbox
              booktabs translator minted fvextra upquote lineno ifplatform
              xstring framed float;
  };

  # Add development tools on top of the package dependencies since the package build shouldn't depend on dev tools
  haskellDevEnv = haskellPkgs.ghcWithPackages (p: with p; [
    ghcid
    cabal-install
    stylish-haskell
    stylish-cabal
    doctest
    hlint
    hoogle
    hasktags
  ]);
in haskellPkgs.shellFor {
  packages = p: with p; [ lyah ];
  buildInputs =with pkgs; [
    cabal2nix
    bats
    haskellDevEnv
    pythonPackages.pygments
    graphviz
    geckodriver
  ];
  withHoogle = true;
}
