{ pkgs ? import (builtins.fetchTarball {
    # branches nixos-19.03
    url = "https://github.com/NixOS/nixpkgs-channels/archive/96151a48dd6662fb3f84bd16bbfe8a34f59d717a.tar.gz";
    sha256 = "06cqc37yj23g3jbwvlf9704bl5dg8vrzqvs5y2q18ayg9sw61i6z";
  }) {}
}:

with pkgs;

stdenv.mkDerivation rec {
  name = "env";
  src = ./.;
  env = buildEnv { name = name; paths = buildInputs; };
  builder = builtins.toFile "builder.pl" ''
    source $stdenv/setup; ln -s $env $out
  '';
  buildInputs = [
    (texlive.combine {
      inherit (texlive)
        scheme-basic
        appendixnumberbeamer
        beamer
        beamertheme-metropolis
        booktabs
        ccicons
        cm-super
        ec
        enumitem
        epstopdf
        etoolbox
        fancyvrb
        fira
        float
        fontaxes
        framed
        fvextra
        graphics
        hyperref
        ifplatform
        latex
        latexmk
        lineno
        microtype
        minted
        ms
        mweights
        fontawesome
        pgf
        pgfopts
        pgfplots
        preview
        translator
        upquote
        xcolor
        xkeyval
        xstring;
    })
    curl
    ghostscript
    gnumake
    pythonPackages.pygments
    unzip
    which
  ];
}
