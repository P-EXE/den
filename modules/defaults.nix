{ lib, den, ... }: {
  den.default.nixos = {
    nixpkgs.config.allowUnfree = true;
    nix.settings = {
      trusted-users = [ "@wheel" ];
      experimental-features = [ "nix-command" "flakes" ];
    };
    system.stateVersion = "25.11";
  };
  den.default.homeManager = {
    nixpkgs.config.allowUnfree = true;
    home.stateVersion = "25.11";
  };

  # enable hm by default
  den.schema.user.classes = lib.mkDefault [ "homeManager" ];

  # host<->user provides
  den.ctx.user.includes = [ den._.mutual-provider ];

  # User TODO: REMOVE THIS
  den.aspects.tux.nixos = {
    boot.loader.grub.enable = false;
    fileSystems."/".device = "/dev/fake";
  };
}
