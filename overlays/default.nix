final: prev: {
  awmtt = prev.callPackage ./awmtt {};
  aawmtt = prev.callPackage ./aawmtt {};

  wezterm = prev.wezterm.overrideAttrs (old: {
    postInstall =
      old.postInstall
      + ''
        substituteInPlace $out/share/applications/org.wezfurlong.wezterm.desktop --replace \
        "Exec=wezterm start --cwd ." \
        "Exec=wezterm"
      '';
  });

  input-leap = prev.input-leap.overrideAttrs (old: {
    version = "2023-10-22";
    src = prev.fetchFromGitHub {
      owner = "input-leap";
      repo = "input-leap";
      rev = "c5bb9dcaad302eff4fe17855c147f640bdb76ba9";
      hash = "sha256-yOiMH5AILjRnNf/Nb2OoSYMM+GSnAhq6QbkvHDQ8eW0=";
      fetchSubmodules = true;
    };
  });
}
