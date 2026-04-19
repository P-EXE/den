{ den, lib, ... }: {
  # host aspect
  den.aspects.blackbox = {
    includes = with den.aspects; [
      plex
    ] + lib.attrValues den.aspects.blackbox._;
    nixos = { lib, config, pkgs, modulesPath,  ... }: {
      imports =[
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      environment.systemPackages = [ pkgs.hello ];

      # Networking
        networking = {
          hostName = "Blackbox";
          firewall = {
            enable = false;
            allowedTCPPorts = [ ];
            allowedUDPPorts = [ ];
          };
          networkmanager.enable = true;
        };
        services = {
          printing.enable = true;
          openssh.enable = true;
        };

      # Locale
        services.xserver.xkb = {
          layout = "us";
          variant = "";
        };
        time.timeZone = "Europe/Vienna";
        i18n.defaultLocale = "en_US.UTF-8";
        i18n.extraLocaleSettings = {
          LC_ADDRESS = "de_AT.UTF-8";
          LC_IDENTIFICATION = "de_AT.UTF-8";
          LC_MEASUREMENT = "de_AT.UTF-8";
          LC_MONETARY = "de_AT.UTF-8";
          LC_NAME = "de_AT.UTF-8";
          LC_NUMERIC = "de_AT.UTF-8";
          LC_PAPER = "de_AT.UTF-8";
          LC_TELEPHONE = "de_AT.UTF-8";
          LC_TIME = "de_AT.UTF-8";
        };

      # System
        # Nix
          system.stateVersion = "25.11";
          nix.settings.experimental-features = [ "nix-command" "flakes" ];
          nixpkgs.config.allowUnfree = true;
        # Boot
          boot.loader.systemd-boot.enable = true;
          boot.loader.efi.canTouchEfiVariables = true;
        # Kernel
          boot.kernelPackages = pkgs.linuxPackages_latest;
          boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
          boot.initrd.kernelModules = [ ];
          boot.kernelModules = [ "kvm-intel" "dm-raid" ];
          boot.extraModulePackages = [ ];
    
      # Hardware
        #CPU
          hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
        # Disks
          boot.swraid.enable = true;
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
            #"/mnt/storage" = {
            #  device = "/dev/pool/lvraid1";
            #  fsType = "btrfs";
            #};
          };
          swapDevices = [ ];
    };
  };
}