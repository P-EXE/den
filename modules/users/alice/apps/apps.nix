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
        ouch

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

      services.udiskie = {
        enable = true;
        automount = true;
        tray = "auto";
        notify = false;
        settings = {
          mount_path = "~/Desktop";
        };
      };
    };
  };
}