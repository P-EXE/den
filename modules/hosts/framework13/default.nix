{ inputs, den, ... }: {

  flake-file.inputs = {
    hyprland = {
      url = "github:hyprwm/Hyprland";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
  };

  # host aspect
  den.aspects.framework13 = {
    imports = [
      inputs.nixos-hardware.nixosModules.framework.amd-7040
    ];

    includes = with den.aspects; [
      virtualization._.docker
      server._.plex
    ];

    # host NixOS configuration
    nixos = { pkgs, ... }: {
      environment.systemPackages = [ pkgs.hello ];
      
      imports = [
        ../../../nixos/framework13/configuration.nix
      ];
      
      programs.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
        withUWSM = true;
        xwayland.enable = true;
      };
      
      nixpkgs.config.allowUnfree = true;
      nix.settings.experimental-features = [ "nix-command" "flakes" ];
    };

    # host provides default home environment for its users
    provides.to-users.homeManager = { pkgs, ... }: {
      home.packages = [ pkgs.vim ];
    };
  };
}
