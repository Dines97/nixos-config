{
  stdenv,
  lib,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "awmtt";
  version = "2017-02-14";

  src = fetchFromGitHub {
    repo = pname;
    owner = "gmdfalk";
    rev = "92ababc7616bff1a7ac0a8e75e0d20a37c1e551e";
    sha256 = "sha256-3IpCuLIdN4t4FzFSHAlJ9FW9Y8UcWIqXG9DfiAwZoMY=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp awmtt.sh $out/bin/awmtt
    chmod 0700 $out/bin/awmtt
  '';
}
