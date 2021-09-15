{
  description = "Personal website written and deployed via Jekyll";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, ... }@inputs:
    with inputs;
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages."${system}";
        build-deps = with pkgs; [
          jekyll
        ];
      in
      rec {
        devShell = pkgs.mkShell {
          buildInputs = build-deps;
        };

        packages.site = pkgs.stdenv.mkDerivation {
          name = "houstdav000-site";
          src = ./.;
          nativeBuildInputs = build-deps;          unpackPhase = ''
            cp -r $src/* .
          '';
          buildPhase = ''
            jekyll build
            '';
          installPhase = ''
            cp -r _site/ $out
          '';
        };
        defaultPackage = packages.site;
      });
}
