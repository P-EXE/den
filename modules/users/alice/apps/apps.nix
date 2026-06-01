{ den, inputs, lib, ... }: {
  den.aspects.alice._.apps = {
    includes = lib.attrValues den.aspects.alice._.apps._;
    homeManager = {pkgs, config, ...}: {
      home.packages = with pkgs; [
        htop
        btop
        bottom
        cbonsai
        fastfetch

        qbittorrent

        spotify
        mpv
        obsidian
        steam
        ungoogled-chromium
        #google-chrome

      ];
      programs.firefox.enable = true;
      programs.firefox.configPath = "${config.xdg.configHome}/mozilla/firefox";
    };
  };
}