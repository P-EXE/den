{ den, pkgs, ... }: {
  den.aspects.graphics.nixos.environment.systemPackages = with pkgs; [
    blender
  ];
}