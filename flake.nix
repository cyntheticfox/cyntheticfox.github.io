{
  description = "Personal website written and deployed via Jekyll";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, flake-utils, nixpkgs }:

    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages."${system}";

        build-deps = with pkgs; [ jekyll ];
      in
      {
        devShells.default = pkgs.mkShell {
          packages = build-deps;
        };

        packages = {
          default = self.packages."${system}".site;

          site = pkgs.stdenv.mkDerivation {
            name = "houstdav000-site";
            src = ./.;
            nativeBuildInputs = build-deps;

            buildPhase = ''
              jekyll build
            '';

            installPhase = ''
              cp -r _site/ $out
            '';
          };
        };
      });
}
