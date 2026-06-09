{ lib, den, ... }: {
  den.default.nixos = {
    nixpkgs.config.allowUnfree = true;
    nix.settings = {
      trusted-users = [ "@wheel" "alice" ];
      experimental-features = [ "nix-command" "flakes" ];
      builders-use-substitutes = true;
      extra-substituters = [];
      extra-trusted-public-keys = [];
    };

    programs.nix-ld.enable = true;
  };
  den.default.homeManager = {
    nixpkgs.config.allowUnfree = true;
    #nix.settings = {
    #  trusted-users = [ "@wheel" ];
    #  experimental-features = [ "nix-command" "flakes" ];
    #};
    home.stateVersion = "26.05";
  };

  # enable hm by default
  den.schema.user.classes = lib.mkDefault [ "homeManager" ];

  # host<->user provides
  den.schema.user.includes = [ den._.mutual-provider ];

  # User TODO: REMOVE THIS
  den.aspects.tux.nixos = {
    boot.loader.grub.enable = false;
    fileSystems."/".device = "/dev/fake";
  };
}
