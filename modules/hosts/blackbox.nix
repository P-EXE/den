{
  # host aspect
  den.aspects.blackbox = {
    nixos = { lib, config, pkgs, modulesPath,  ... }: {
      imports =[
        (modulesPath + "/installer/scan/not-detected.nix")
      ];
    };
  };
}