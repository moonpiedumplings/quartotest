{ pkgs ? import <nixpkgs> {} } :
    pkgs.mkShell {
        packages = [ pkgs.quarto pkgs.jupyter pkgs.pandoc pkgs.deno pkgs.mkpasswd ];
    }