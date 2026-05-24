{ den, inputs, lib, ... }: {
  # user aspect
  den.aspects.alice = {
    includes = [
      den.provides.define-user
      den.provides.primary-user
      (den.provides.user-shell "fish")
      den.aspects.alice._.desktop
      den.aspects.alice._.apps
      den.aspects.alice._.coding
    ];
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [ 
        htop
      ];
    };
    nixos = {
      users.users.alice.extraGroups = [
        "sambagroup"
      ];
    };
    # user can provide NixOS configurations
    # to any host it is included on
    provides.to-hosts.nixos = { pkgs, ... }: { 
    };
    # Aspects
    _.themes._.archive = {
      homeManager = { pkgs,  ... }: {
        home.packages = with pkgs; [
          jetbrains-mono
        ];
        
        home.pointerCursor = {
          gtk.enable = true;
          package = pkgs.bibata-cursors;
          name = "Bibata-Original-Classic";
          size = 4;
        };    

        gtk = with pkgs; {
          enable = true;
          theme = {
            package = adw-gtk3;
            name = "adw-gtk3-dark";
          };
          iconTheme = {
            package = papirus-icon-theme;
            name = "Papirus-Dark";
          };
          gtk3.extraConfig = {
            Settings = ''
              gtk-application-prefer-dark-theme=1
            '';
          };
          gtk4.extraConfig = {
            Settings = ''
              gtk-application-prefer-dark-theme=1
            '';
          };
        };
      };
    };
  };
}
