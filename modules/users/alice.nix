{ den, lib, ... }: {
  # user aspect
  den.aspects.alice = {
    includes = [
      den.provides.define-user
      den.provides.primary-user
      (den.provides.user-shell "fish")
      den.aspects.alice._.desktops._.hyprland
      den.aspects.alice._.apps
      den.aspects.alice._.coding
    ];
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [ 
        pkgs.htop
      ];
    };
    # user can provide NixOS configurations
    # to any host it is included on
    provides.to-hosts.nixos = { pkgs, ... }: { };
    # Aspects
    _.desktops._.hyprland = {
      homeManager = {
        wayland.windowManager.hyprland = {
          enable = true;
        };
      };
    };
    _.apps = {
      includes = lib.attrValues den.aspects.alice._.apps._;
      _.browsers = {
        homeManager = {
          programs.firefox.enable = true;
        };
      };
      _.media = {
        homeManager = {
          programs.spotify-player.enable = true;
        };
      };
    };
    _.coding = {
      includes = lib.attrValues den.aspects.alice._.coding._;
      _.editors = {
        homeManager = {
          programs.vscode.enable = true;
        };
      };
      _.tools = {
        homeManager = {
          programs.git.enable = true;
        };
      };
    };
  };
}
