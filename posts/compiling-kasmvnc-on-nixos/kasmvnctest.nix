{
    stdenv,
    lib,
    fetchurl,
    makeWrapper,
    perl536Packages
} :

stdenv.mkDerivation rec {
  pname = "kasmvnc";
  version = "1.1.0";
  src = fetchurl {
    url = "https://github.com/kasmtech/KasmVNC/releases/download/v${version}/kasmvnc.alpine_317_x86_64.tgz";
    sha256 = "sha256-j/3PUwBd8XygBKYfFdAwN15cwxDPf3vbEwbLy1laxSU=";
  };

  nativeBuildInputs = [
    makeWrapper
  ];

  patches = [
  ];

  postPatch = ''
  '';

  dontStrip = true;

  preFixup = ''
        wrapProgram $out/bin/vncserver \
         --prefix PERLLIB : $out/bin  \
         --prefix PERLLIB : ${perl536Packages.ModuleBuildTiny}/lib
  '';

  installPhase = ''
      runHook preInstall

      mkdir -p $out/bin $out/share $out/man $out/etc $out/lib

      echo here
      ls
      ls local/bin

      mv local/etc/* $out/etc
      mv local/share/* $out/share
      mv local/man/* $out/man
      mv local/lib/* $out/lib
      mv local/bin/* $out/bin

      runHook preInstall
  '';

  meta = with lib; {
    description = "Kasmvnc";
    longDescription = ''
        Kasmvnc
    '';
    homepage = "";
    changelog = "https://github.com/kasmtech/KasmVNC/releases/tag/v${version}";
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ moonpiedumplings ];
    platforms = [ "x86_64-linux" ];
    sourceProvenance = with sourceTypes; [ binaryNativeCode binaryBytecode ];
  };
}
