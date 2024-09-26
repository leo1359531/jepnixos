{
  stdenvNoCC,
  fetchFromGitLab,
}:
stdenvNoCC.mkDerivation {
  pname = "eigen";
  version = "3.4.0";

  src = fetchFromGitLab {
    owner = "libeigen";
    repo = "eigen";
    rev = "2a3465102ac48d5e71b134d77b25665d63120eff";
    sha256 = "sha256-Vdn5/52PwgDQjN++9ahvjVHhwMgGjq2DKOpv/aDqxUQ=";
  };

  installPhase = ''
    mkdir -p $out/include
    mv Eigen $out/include
  '';
}
