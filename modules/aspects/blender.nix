{ den, inputs, lib, ... }: {
  flake-file = {
    inputs = {
      blender-cuda.url = "github:adithyagenie/blender-cuda-nixos";
    };
  };
  den.aspects.blender = {
    includes = with den.aspects; [
      cuda
    ];
    nixos = { pkgs, ... } : {
      environment.systemPackages = [
        inputs.blender-cuda.packages.${pkgs.system}.blender-with-cuda
      ];
    };
    homeManager = { pkgs, ... }: {
      home.packages = [
        inputs.blender-cuda.packages.${pkgs.system}.blender-with-cuda
      ];
    };
  };
}
