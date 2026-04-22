{ den, inputs, ... }: {
  flake-file.inputs.niri = {
    url = "github:sodiboo/niri-flake";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  den.aspects.alice._.desktops._.niri = {
    nixos = {
      programs.niri.enable = true;
    };
    homeManager = {
      imports = [
        inputs.niri.homeModules.niri
      ];
      programs.niri.settings = {
        #layout = {
        #  border = {
        #    enable = false;
        #    width = 1;
        #  };
      };
    };
  };
}