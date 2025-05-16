{
  pkgs,
  lib,
  inputs,
  ...
}: {
  nix = {
    settings.system-features = ["gccarch-znver5" "benchmark" "big-parallel" "kvm"];

    sshServe = {
      enable = true;
      protocol = "ssh-ng";
      write = true;
    };
  };
}

