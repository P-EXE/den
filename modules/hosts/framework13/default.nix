{ inputs, den, ... }: {
  den.aspects.framework13 = {
    includes = with den.aspects; [
      virtualization._.docker
      server._.plex
    ];
    nixos = { pkgs, ... }: {
      environment.systemPackages = [ pkgs.hello ];
      imports = [
        ../../../nixos/framework13/configuration.nix
      ];
      nixpkgs.config.allowUnfree = true;
      nix.settings.experimental-features = [ "nix-command" "flakes" ];
    };
    provides.to-users.homeManager = { pkgs, ... }: {
      home.packages = [ pkgs.vim ];
    };
  };
}
