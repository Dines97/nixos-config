{
  disko.devices = {
    disk = {
      nvme0n1 = {
        device = "/dev/disk/by-path/pci-0000:03:00.0-nvme-1";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              end = "1G";
              type = "EF00"; # gdisk: Create a partition with partition type EF00.
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            root = {
              name = "root";
              end = "-0";
              content = {
                type = "filesystem";
                format = "bcachefs";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}
