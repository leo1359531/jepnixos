{
  lib,
  stdenv,
  fetchzip,
  cmake,
}:
stdenv.mkDerivation rec {
  pname = "lis";
  version = "2.1.6";

  src = fetchzip {
    url = "https://www.ssisc.org/lis/dl/lis-2.1.6.zip";
    sha256 = "sha256-reyfup0dcV8UF1BRV9rrPJuCSKSNIx/xEiZ7I1ni6QM=";
  };

  buildInputs = [
    cmake
  ];

  configurePhase = ''
    ./configure
  '';

  buildPhase = ''
    make
  '';

  installPhase = ''
    make check

    mkdir -p $out/bin
    mv test/lsolve $out/bin
    mv test/esolve $out/bin
    mv test/esolver $out/bin
    mv test/gesolve $out/bin
    mv test/gesolver $out/bin
    mv test/hpcg_kernel $out/bin
    mv test/hpcg_spmvtest $out/bin

    mkdir -p std-include
    mv include/lis_config.h std-include/lis_config.h
    mv include/lis.h std-include/lis.h
    mv include/lisf.h std-include/lisf.h

    mkdir -p $out/lib
    mv src/liblis.la $out/lib

    mkdir -p $out/share
    mv doc/man $out/share
  '';
}
