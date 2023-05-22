{ pkgs ? import <nixpkgs> {} } :
    pkgs.mkShell {
        packages = with pkgs; [ python311Full quarto jupyter pandoc deno mkpasswd ];
    }
