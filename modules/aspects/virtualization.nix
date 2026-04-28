{ den, inputs, lib, ... }: {
  den.aspects.virtualization = {
    includes = lib.attrValues den.aspects.virtualization._;
    _.containers = {
      nixos = {
        virtualisation.docker = {
          enable = true;
          storageDriver = "btrfs";
        };
        users.extraGroups.docker.members = [ "alice" ];
      };
    };
    _.vm = {
      nixos = { pkgs, ...}: {
        virtualisation = {
          libvirtd = {
            enable = true;
            qemu = {
              package = pkgs.qemu_kvm;
              runAsRoot = true;
              swtpm.enable = true;
              vhostUserPackages = [ pkgs.virtiofsd ];
            };
          };
        };
        services.spice-vdagentd.enable = true;
        # QEMU stuff
        programs.dconf.enable = true;
        environment.systemPackages = with pkgs; [
          virt-manager
          virt-viewer
          spice
          spice-gtk
          spice-protocol
          virtio-win
          win-spice
        ];
        systemd.tmpfiles.rules = [ "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware" ];
        users.users."alice" = {
          extraGroups = [
            "libvirtd"
          ];
        };
      };
    };
  };
}