{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/671fd3a3c13383cc1d7805e2b7854b5226205d07.tar.gz") { } }:
pkgs.mkShell {
  buildInputs = with pkgs; [
    jekyll
  ];
}
