{ lib
, aiohttp
, buildPythonPackage
, fetchFromGitHub
, libopus
, pynacl
, pythonOlder
, withVoice ? true
, ffmpeg
}:

buildPythonPackage rec {
  pname = "pycord";
  version = "2.0.0-rc.1";
  format = "setuptools";

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "Pycord-Development";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-PlO811gkOtXaj/RsG010UQwkkNQ7oKG09aUvzJDSImA=";
  };

  propagatedBuildInputs = [
    aiohttp
  ] ++ lib.optionals withVoice [
    libopus
    pynacl
    ffmpeg
  ];

  patchPhase = ''
    substituteInPlace "discord/opus.py" \
      --replace "ctypes.util.find_library('opus')" "'${libopus}/lib/libopus.so.0'"
    substituteInPlace requirements.txt \
      --replace "aiohttp>=3.6.0,<3.8.0" "aiohttp>=3.6.0,<4"
  '' + lib.optionalString withVoice ''
    substituteInPlace "discord/player.py" \
      --replace "executable='ffmpeg'" "executable='${ffmpeg}/bin/ffmpeg'"
  '';

  # Only have integration tests with discord
  doCheck = false;

  pythonImportsCheck = [
    "discord"
    "discord.file"
    "discord.member"
    "discord.user"
    "discord.state"
    "discord.guild"
    "discord.webhook"
    "discord.ext.commands.bot"
  ];

  meta = with lib; {
    description = "Pycord, a maintained fork of discord.py, is a python wrapper for the Discord API";
    homepage = "https://docs.pycord.dev/";
    license = licenses.mit;
  };
}

