{ den, ... }: {
  # host aspect
  den.aspects.framework13 = {
    includes = with den.aspects; [
      virtualization
    ];

    # host NixOS configuration
    nixos = { lib, config, pkgs, modulesPath,  ... }: {
      imports =[
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      # Desktops (TODO: remove and aspectrize)
        services.xserver.enable = true;
        services.xserver.displayManager.gdm.enable = true;
        services.xserver.desktopManager.gnome.enable = true;

      environment.systemPackages = with pkgs; [
        udiskie
        brightnessctl
      ];

      # Network & Wireless
        networking = {
          hostName = "Framework13";
          firewall = {
            enable = true;
            allowedTCPPorts = [ ];
            allowedUDPPorts = [ ];
          };
          networkmanager.enable = false;
          wireless = {
            iwd.enable = true;
          };
        };
        services.printing.enable = true;
        hardware.bluetooth.enable = true;
        services.blueman.enable = true;

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
        # Nixos
          system.stateVersion = "26.05";

      # Hardware
        # Biometrics
          services.fprintd.enable = true;
          #systemd.services.fprintd = {
          #  wantedBy = [ "multi-user.target" ];
          #  serviceConfig.Type = "simple";
          #};
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
          services.gvfs.enable = true;
          services.udisks2.enable = true;
          fileSystems = {
            "/" = { 
              device = "/dev/disk/by-uuid/72e459ad-ebf3-41ab-aaac-6a8ec243b4dc";
              fsType = "btrfs";
            };
            "/home" = { 
              device = "/dev/disk/by-uuid/72e459ad-ebf3-41ab-aaac-6a8ec243b4dc";
              fsType = "btrfs";
              options = [ "subvol=home" ];
            };
            "/nix" = { 
              device = "/dev/disk/by-uuid/72e459ad-ebf3-41ab-aaac-6a8ec243b4dc";
              fsType = "btrfs";
              options = [ "subvol=nix" ];
            };
            "/boot" = { 
              device = "/dev/disk/by-uuid/1FB6-02DC";
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
