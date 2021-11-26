let
  sources = import ./sources.nix;
in
{ nixpkgs ? sources.nixpkgs
, niv ? sources.niv
, smooth-prim ? sources.smooth-prim
}:
let
  niv-overlay = self: _: {
    niv = self.symlinkJoin {
      name = "niv";
      paths = [ niv ];
      buildInputs = [ self.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/niv \
          --add-flags "--sources-file ${toString ./sources.json}"
      '';
    };
  };

  pkgs = import nixpkgs {
    overlays = [ niv-overlay ];
    config = { };
  };

  OPENSCADPATH = pkgs.linkFarm "openscad-path" [
    { name = "smooth-prim"; path = smooth-prim; }
  ];

  build = pkgs.writeShellScriptBin "build" ''
    mkdir -p build
    ${pkgs.openscad}/bin/openscad -o build/''${1%%.scad}.stl $1
  '';
in
pkgs.mkShell {
  inherit OPENSCADPATH;

  buildInputs = [
    pkgs.git
    pkgs.niv
    pkgs.openscad
    pkgs.prusa-slicer
    pkgs.freecad
    build
  ];
}
