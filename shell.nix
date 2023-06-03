{ pkgs ? import <nixpkgs> {} } :
let 
    pandoc = null;

    extraRPackages = [];
    extraPythonPackages = ps: with ps; [];


    quarto = (pkgs.quarto.overrideAttrs (oldAttrs: rec {
        version = "1.3.361";
        src = pkgs.fetchurl {
            url = "https://github.com/quarto-dev/quarto-cli/releases/download/v${version}/quarto-${version}-linux-amd64.tar.gz";
            sha256 = "sha256-vvnrIUhjsBXkJJ6VFsotRxkuccYOGQstIlSNWIY5nuE=";
        };
        patches = [];
        preFixup = ''
            wrapProgram $out/bin/quarto \
            --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.deno ]} \
            --prefix QUARTO_PANDOC : $out/bin/tools/pandoc \
            --prefix QUARTO_ESBUILD : ${pkgs.esbuild}/bin/esbuild \
            --prefix QUARTO_DART_SASS : $out/bin/tools/dart-sass/sass \
            --prefix QUARTO_R : ${pkgs.rWrapper.override { packages = [ pkgs.rPackages.rmarkdown ] ++ extraRPackages; }}/bin/R \
            --prefix QUARTO_PYTHON : ${pkgs.python3.withPackages (ps: with ps; [ jupyter ipython ] ++ (extraPythonPackages ps))}/bin/python3
        '';
        installPhase = ''
            runHook preInstall

            mkdir -p $out/bin $out/share

            mv bin/* $out/bin
            mv share/* $out/share

            runHook preInstall
            '';
    })).override {inherit pandoc extraPythonPackages extraRPackages;};
in
    pkgs.mkShell {

        packages = with pkgs; [ python310Full quarto jupyter ];
    }
