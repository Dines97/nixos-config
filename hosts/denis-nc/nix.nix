{
  pkgs,
  lib,
  inputs,
  ...
}: {
  nix = {
    settings = {
      # substituters = [
      #   "ssh://denis@dt826.local"
      # ];
    };

    buildMachines = [
      {
        hostName = "denis@dt826.local";
        system = "x86_64-linux";
        protocol = "ssh-ng";
        maxJobs = 8;
        speedFactor = 4;
        # supportedFeatures = ["nixos-test" "benchmark" "big-parallel" "kvm"];
        # mandatoryFeatures = [];
      }
    ];
  };
}
