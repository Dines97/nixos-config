{
  stdenv,
  python3,
  fetchFromGitHub,
}: let
  pname = "asus-touchpad-numpad-driver";
  version = "2023-11-14";
in
  stdenv.mkDerivation {
    inherit pname version;

    src = fetchFromGitHub {
      owner = "mohamed-badaoui";
      repo = "asus-touchpad-numpad-driver";
      rev = "bfbd282025e1aeb2c805a881e01089fe55442e7f";
      sha256 = "sha256-NkJ2xF4111fXDUPGRUvIVXyyFmJOrlSq0u6jJUJFYes=";
    };

    # dontUnpack = true;
    # dontConfigure = true;
    # dontBuild = true;

    propagatedBuildInputs = [
      (python3.withPackages (ps: with ps; [libevdev]))
    ];

    installPhase = ''
      mkdir -p $out/lib/asus_touchpad

      install -Dm755 $src/asus_touchpad.py $out/bin/asus_touchpad.py
      cp -R $src/numpad_layouts $out/lib/asus_touchpad/numpad_layouts
    '';
  }
