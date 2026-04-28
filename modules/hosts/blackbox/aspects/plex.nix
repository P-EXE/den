{ den, ... }: {
  den.aspects.blackbox._.plex = {
    nixos = { pkgs, ... } : {
      services.plex = {
        enable = true;
        openFirewall = true;
      };
    };
  };
}