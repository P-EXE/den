{ den, inputs, lib, ... }: {
  den.aspects.alice._.apps = {
    #includes = lib.attrValues den.aspects.alice._.apps._;
    homeManager = {pkgs, config, ...}: {
      programs.firefox.enable = true;
      programs.firefox.configPath = "${config.xdg.configHome}/mozilla/firefox";
      home.packages = with pkgs; [
        htop
        btop
        bottom
        cbonsai
        fastfetch

        qbittorrent

        spotify
        obsidian
        steam
        #ungoogled-chromium
        #google-chrome
      ];
    };
  };
}