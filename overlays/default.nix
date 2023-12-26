final: prev: {
  awmtt = prev.callPackage ./awmtt {};
  aawmtt = prev.callPackage ./aawmtt {};

  # remote-desktop-manager = prev.callPackage ./remote-desktop-manager {};

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
    version = "2023-11-21";
    src = prev.fetchFromGitHub {
      owner = "input-leap";
      repo = "input-leap";
      rev = "3e681454b737633a70f2f3b789046a5cb1946708";
      hash = "sha256-OZMVz075oC7UQI7F9uDz8F6eBr1WN4aYxLFq9bc3M6g=";
      fetchSubmodules = true;
    };
  });
}
