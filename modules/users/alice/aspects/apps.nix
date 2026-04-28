{ den, inputs, lib, ... }: {
  den.aspects.alice._.apps = {
    #includes = lib.attrValues den.aspects.alice._.apps._;
    homeManager = {pkgs, ...}: {
      programs.firefox.enable = true;
      home.packages = with pkgs; [
        htop
        btop
        bottom
        cbonsai
        fastfetch

        spotify
        obsidian
        steam
      ];
    };
  };
}