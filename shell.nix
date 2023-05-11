{ pkgs ? import <nixpkgs> {} } :
    pkgs.mkShell {
        packages = with pkgs; [ quarto jupyter pandoc deno mkpasswd ];
    }