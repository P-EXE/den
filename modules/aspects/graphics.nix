{ den, ... }: {
  den.aspects.graphics = {
    nixos = { pkgs, ... } : {
      environment.systemPackages = with pkgs; [
        blender
      ];
    };
  };
}
