# Example to create a bios compatible gpt partition
{lib, ...}: {
  disko.devices = {
    # Define the single disk with GPT, an EFI System Partition, and LVM PV
    disk = {
      nvme0n1 = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-WD_BLACK_SN850X_2000GB_250403804772";
        content = {
          type = "gpt";
          partitions = {
            # EFI System Partition for UEFI boot
            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            # LVM Physical Volume occupying the rest of the disk
            pv = {
              size = "100%";
              content = {
                type = "lvm_pv";
                vg = "vgroot";
              };
            };
          };
        };
      };
    };

    # Volume Group and Logical Volumes
    lvm_vg = {
      vgroot = {
        type = "lvm_vg";
        lvs = {
          # Root filesystem (50% of VG)
          root = {
            size = "100%FREE";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
            };
          };
          # Home filesystem (remaining 50% of VG)
          home = {
            size = "100%FREE";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/home";
            };
          };
        };
      };
    };
  };
}

