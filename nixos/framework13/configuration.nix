{ config, pkgs, ... }: {
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Available Desktops

  # Available system packages
  environment.systemPackages = with pkgs; [
    udiskie
    brightnessctl
    
    # VMs
    virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    virtio-win
    win-spice
  ];
  
  # Available system services
    # Virtualisation
      # Containers
      virtualisation = {
        containers.enable = true;
        docker = {
          enable = true;
          storageDriver = "btrfs";
        };
      };
      # VMs    
      virtualisation.libvirtd = {
        enable = true;
        qemu = {
          package = pkgs.qemu_kvm;
          runAsRoot = true;
          swtpm.enable = true;
          vhostUserPackages = [ pkgs.virtiofsd ];
        };
      };
      services.spice-vdagentd.enable = true;
      programs.dconf.enable = true;
      systemd.tmpfiles.rules = [ "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware" ];
      
  # Locale
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
  # Network
  networking = {
    hostName = "NixOS-Framework13";
    #proxy = {
    #  default = "http://user:password@proxy:port/";
    #  noProxy = "127.0.0.1,localhost,internal.domain";
    #};
    firewall = {
      enable = true;
      allowedTCPPortRanges = [];
      allowedUDPPortRanges = [];
      checkReversePath = false;
    };
    networkmanager.enable = true;
    # Workaround for wifi unavailable after rebuild
    #networking.wireless.iwd.enable = true;
    #networkmanager.wifi.backend = "iwd";
  };
  services.openssh.enable = true;
  services.printing.enable = true;
  # Available essentials services with associated hardware
  # Blockdevices
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  # USB
  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
  };
  # Graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  # Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
  };
  # Bluetooth
  hardware.bluetooth.enable = true;
  # Fingerprint
  services.fprintd.enable = true;
  systemd.services.fprintd = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "simple";
  };
  # Nix
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Startup & System
  # Bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    efi.efiSysMountPoint = "/boot";
    systemd-boot.configurationLimit = 3;
  };
  # Kernel
  #boot.kernelPackages = pkgs.linuxPackages_latest;
    # Workaround for wifi unavailable after rebuild
    boot.kernelPackages = pkgs.linuxPackages_6_12;
  # State version
  system.stateVersion = "25.11";
}
