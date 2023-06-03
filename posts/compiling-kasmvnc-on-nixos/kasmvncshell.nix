{
    pkgs ? import <nixpkgs> {},
    #kasmvnc ? import ./kasmvnctest.nix {},
} :

let kasmvnc = pkgs.callPackage ./kasmvnctest.nix {}; in
pkgs.mkShell {
    packages = [ kasmvnc ];
}
