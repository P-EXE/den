{ den, inputs, lib, ... }: {
  flake-file = {
    inputs = {
    };
  };
  den.aspects.alice._.desktops._.sway = {
    nixos = {
      programs.sway = {
        enable = true;
        wrapperFeatures.gtk = true;
      };
    };
    homeManager = {
      wayland.windowManager.sway = {
        enable = true;
        wrapperFeatures.gtk = true; # Fixes common issues with GTK 3 apps
        config = rec {
          modifier = "Mod4";
          # Use kitty as default terminal
          terminal = "kitty"; 
          startup = [
            # Launch Firefox on start
            {command = "firefox";}
          ];
        };
      };
    };
  };
}