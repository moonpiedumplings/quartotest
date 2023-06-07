{
    pkgs ? import <nixpkgs> {},
} :

let kasmvnc = pkgs.callPackage ./kasmvnctest.nix {}; in
pkgs.mkShell {
    packages = [ kasmvnc ];
}
