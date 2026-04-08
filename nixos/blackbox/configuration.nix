{ lib, pkgs, config, ... } : {
  users.users.ingrid = {
    isSystemUser = true;
    description = "Ingrid's user, doesn't need a home dir for now";
    group = "sambagroup";
  };
  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "blackbox-samba";
        "netbios name" = "blackbox-samba";
        "security" = "user";
        #"use sendfile" = "yes";
        #"max protocol" = "smb2";
        # note: localhost is the ipv6 localhost ::1
        "hosts allow" = "192.168.1. 127.0.0.1 localhost";
        "hosts deny" = "0.0.0.0/0";
        "guest account" = "nobody";
        "map to guest" = "bad user";
      };
      "public" = {
        #"path" = "/mnt/storage/shares/public";
        "path" = "/mnt/potentially_broken_drive/shares/public";
        "browseable" = "yes";
        "read only" = "no";
        "public" = "yes";
        "create mask" = "0755";
        "directory mask" = "0755";
        "vfs objects" = "catia fruit streams_xattr";
      };
	    "internal" = {
        #"path" = "/mnt/storage/shares/internal";
        "path" = "/mnt/potentially_broken_drive/shares/internal";
        "browseable" = "yes";
        "read only" = "yes";
        "public" = "yes";
        "create mask" = "0644";
        "directory mask" = "2777";
        "valid users" = "@sambagroup";
        "write list" = "@sambagroup";
        "vfs objects" = "catia fruit streams_xattr";
      };
      "timemachine" = {
        #"path" = "/mnt/storage/shares/timemachine/alice";
        "path" = "/mnt/potentially_broken_drive/shares/timemachine/alice";
        "browseable" = "no";
        "read only" = "no";
        "public" = "no";
        "create mask" = "0755";
        "directory mask" = "0755";
        "vfs objects" = "catia fruit streams_xattr";
      };
      "alice" = {
        #"path" = "/mnt/storage/shares/alice";
        "path" = "/mnt/potentially_broken_drive/shares/alice";
        "browseable" = "no";
        "read only" = "yes";
        "public" = "no";
        "create mask" = "0755";
        "directory mask" = "0755";
	      "valid users" = "alice";
        "write list" = "alice";
        "vfs objects" = "catia fruit streams_xattr";
      };
      "ingrid" = {
        #"path" = "/mnt/storage/shares/ingrid";
        "path" = "/mnt/potentially_broken_drive/shares/ingrid";
        "browseable" = "no";
        "read only" = "yes";
        "public" = "no";
        "create mask" = "0755";
        "directory mask" = "0755";
	      "valid users" = "ingrid";
        "write list" = "ingrid";
        "vfs objects" = "catia fruit streams_xattr";
      };
    };
  };
  users.users.sambauser = {
    isSystemUser = true;
    description = "The default samba user for public or internal shares";
    group = "sambagroup";
  };
  users.groups.sambagroup = {};
  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };
  services.avahi = {
    publish.enable = true;
    publish.userServices = true;
    # ^^ Needed to allow samba to automatically register mDNS records (without the need for an `extraServiceFile`
    # nssmdns4 = true;
    # ^^ Not one hundred percent sure if this is needed- if it aint broke, don't fix it
    # enable = true;
    # openFirewall = true;
  };

  #services.vscode-server.enable = true;

  environment.systemPackages = with pkgs; [
    git
  ];

  networking = {
    hostName = "nixos";
    firewall.enable = false;
    networkmanager.enable = true;
  };
  services.openssh = {
    enable = true;
  };
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd = { 
      availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
      kernelModules = [ ];
    };
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
    kernelPackages = pkgs.linuxPackages_latest;
  };
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/dba8260e-a03f-4e77-a570-b56f29723849";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };
    "/home" = {
      device = "/dev/disk/by-uuid/dba8260e-a03f-4e77-a570-b56f29723849";
      fsType = "btrfs";
      options = [ "subvol=@home" ];
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/DBE0-9B50";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };
  };
  swapDevices = [ ];
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}