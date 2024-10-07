{pkgs, ...}: let
  callPackage = pkgs.callPackage;
in {
  nixpkgs.overlays = [
    (final: prev: {
      jep = {
        eigen = callPackage ./eigen.nix {};
        fast-sl = callPackage ./fast-sl.nix {};
        forge-mtg = callPackage ./forge.nix {};
        jepmap = callPackage ./jepmap.nix {};
        kanagawa-gtk = callPackage ./kanagawa-gtk.nix {};
        lis = callPackage ./lis.nix {};
        modprobed-db = callPackage ./modprobed-db.nix {};
        ngspice = callPackage ./ngspice.nix {};
        nofetch = callPackage ./nofetch.nix {};
        setPL = callPackage ./setPL.nix {};
      };
    })
  ];
}
