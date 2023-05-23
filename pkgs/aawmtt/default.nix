{
  stdenv,
  lib,
  fetchFromGitHub,
  cmake,
  libX11,
  fmt_9,
  cli11,
  reproc,
  spdlog,
}:
stdenv.mkDerivation rec {
  pname = "aawmtt";
  version = "v2.1";

  src = fetchFromGitHub {
    repo = pname;
    owner = "Curve";
    rev = version;
    sha256 = "sha256-44fo0R4Vf1B8GXtv2c192RCkS6GLUv6ahjGkdLW12yg=";
  };

  patches = [./0001-dont-fetch-dependencies.patch];

  buildInputs = [libX11 fmt_9];

  nativeBuildInputs = [cmake cli11 reproc spdlog];

  meta = {
    homepage = "https://github.com/Curve/aawmtt";
    description = "Another AwesomeWM Testing Tool";
  };
}
