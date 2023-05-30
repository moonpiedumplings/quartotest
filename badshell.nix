{ pkgs ? import <nixpkgs> {} } :
let 
    quarto = pkgs.quarto.overrideAttrs (oldAttrs: rec {
        version = "1.3.361";
        src = pkgs.fetchurl {
            url = "https://github.com/quarto-dev/quarto-cli/releases/download/v${version}/quarto-${version}-linux-amd64.tar.gz";
            sha256 = "sha256-vvnrIUhjsBXkJJ6VFsotRxkuccYOGQstIlSNWIY5nuE=";
        };
    });
in
    pkgs.mkShell {
        packages = with pkgs; [ python310Full quarto jupyter pandoc haskellPackages.doctemplates_0_11 deno mkpasswd ];
    }
