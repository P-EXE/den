{ den, inputs, lib, ... }: {
  flake-file = {
    inputs = {
      hyprland = {
        url = "github:hyprwm/Hyprland";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    };
    nixConfig = {
      extra-substituters = ["https://hyprland.cachix.org"];
      extra-trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };
  };
  den.aspects.alice._.desktops._.hyprland = {
    includes = lib.attrValues den.aspects.alice._.desktops._.hyprland._;
    nixos = { pkgs, ...}: {
      programs.hyprland = {
        enable = true;
        # set the flake package
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        # make sure to also set the portal package, so that they are in sync
        portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      };
    };
    homeManager = { pkgs, ... }: {
      wayland.windowManager.hyprland = {
        enable = true;
        # set the flake package
        package = null; #inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage = null; #inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      };
    };
  };
}