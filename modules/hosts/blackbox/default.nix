{ inputs, den, ... }: {
  flake-file.inputs = {
  };
  den.aspects.blackbox = {
    includes = with den.aspects; [
      virtualization._.docker
      server._.plex
    ];
    nixos = { pkgs, ... }: {
      imports = [
        ../../../nixos/blackbox/configuration.nix
      ];
      nix.settings.experimental-features = [ "nix-command" "flakes" ];
      nixpkgs.config.allowUnfree = true;
    };
    provides.to-users.homeManager = { pkgs, ... }: {
      home.packages = [ pkgs.vim ];
    };
  };
}
