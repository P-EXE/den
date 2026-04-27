{ den, pkgs, ... }: {
  den.aspects.desktop = {
    _.gnome = {
      nixos = { pkgs, ... }: {
        services.displayManager.gdm.enable = true;
        services.desktopManager.gnome.enable = true;

        # To disable installing GNOME's suite of applications
        # and only be left with GNOME shell.
        services.gnome.core-apps.enable = false;
        services.gnome.core-developer-tools.enable = false;
        services.gnome.games.enable = false;
        environment.gnome.excludePackages = with pkgs; [ gnome-tour gnome-user-docs ];
      };
    };
    _.plasma = {
      nixos = {
        services.xserver.enable = true;
        services.desktopManager.plasma6.enable = true;
        services.displayManager.sddm = {
          enable = true;
          wayland.enable = false;
        };
      };
    };
  };
}
