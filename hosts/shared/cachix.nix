{
  pkgs,
  lib,
  ...
}: {
  nix = {
    settings = {
      substituters = [
        "https://cuda-maintainers.cachix.org"
        "https://devenv.cachix.org"
        "https://dines97.cachix.org"
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
        "https://ros.cachix.org"
      ];
      trusted-public-keys = [
        "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
        "dines97.cachix.org-1:9NFilQb91Rfy6sTp3uO0+kvQ7fOZ4yfwHnP6+BI0Enw="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "ros.cachix.org-1:dSyZxI8geDCJrwgvCOHDoAfOm5sV1wCPjBkKL+38Rvo="
      ];
    };
  };
}
