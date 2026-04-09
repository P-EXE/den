{
  # host aspect
  den.aspects.framework13 = {
    # host NixOS configuration
    nixos = { pkgs, ... }: {
      imports =[
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      environment.systemPackages = [ pkgs.hello ];

      # Network
        networking = {
          hostName = "Framework13";
          firewall = {
            enable = true;
            allowedTCPPorts = [ ];
            allowedUDPPorts = [ ];
          };
          networkmanager.enable = true;
        };
        services.printing.enable = true;

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
        # Bootloader.
          boot.loader.systemd-boot.enable = true;
          boot.loader.efi.canTouchEfiVariables = true;
        # Kernel
          boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" "usb_storage" "sd_mod" ];
          boot.initrd.kernelModules = [ ];
          boot.kernelModules = [ "kvm-amd" ];
          boot.extraModulePackages = [ ];

      # Hardware
        # Audio
          services.pulseaudio.enable = false;
          security.rtkit.enable = true;
          services.pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
            jack.enable = true;
            # use the example session manager (no others are packaged yet so this is enabled by default,
            # no need to redefine it in your config for now)
            #media-session.enable = true;
          };
        # CPU
          hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
        # Disks
          fileSystems = {
            "/" = {
              device = "/dev/disk/by-uuid/bccc2480-9a73-4378-a311-335d840e4462";
              fsType = "btrfs";
              options = [ "subvol=@" ];
            };
            "/home" = { 
              device = "/dev/disk/by-uuid/bccc2480-9a73-4378-a311-335d840e4462";
              fsType = "btrfs";
              options = [ "subvol=@home" ];
            };
            "/boot" = { 
              device = "/dev/disk/by-uuid/378C-6CC7";
              fsType = "vfat";
              options = [ "fmask=0077" "dmask=0077" ];
            };
          };
          swapDevices = [ ];
    };

    # host provides default home environment for its users
    _.to-users.homeManager = { pkgs, ... }: {
      home.packages = [ pkgs.vim ];
    };
  };
}
