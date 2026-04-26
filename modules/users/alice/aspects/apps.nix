{ den, inputs, lib, ... }: {
  den.aspects.alice._.apps = {
    includes = lib.attrValues den.aspects.alice._.apps._;
    _.browser = {
      homeManager = { pkgs, ... }: {
        programs.firefox.enable = true;
      };
    };
    _.notes = {
      homeManager = { pkgs, ... }: {
        home.packages = with pkgs; [
          obsidian
        ];
      };
    };
    _.media = {
      homeManager = {pkgs, ...}: {
        home.packages = with pkgs; [
          spotify
        ];
      };
    };
  };
}