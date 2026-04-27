{ den, ... }: {
  den.aspects.graphics = {
    nixos = { pkgs, ... } : {
      nix.settings = {
        substituters = [
          "https://cache.nixos-cuda.org"
        ];
        trusted-public-keys = [
          "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
        ];
      };
      #nixpkgs.config.cudaSupport = true;
      environment.systemPackages = with pkgs; [
        (blender.override {
          config.cudaSupport=true;
          config.rocmSupport=true;
        })
      ];
    };
  };
}
