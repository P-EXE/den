{
  den.aspects.server._.plex = {
    nixos = {
      services.plex = {
        enable = true;
        openFirewall = true;
      };
    };
  };
}