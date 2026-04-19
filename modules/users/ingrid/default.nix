{ den, inputs, lib, ... }: {
  # user aspect
  den.aspects.ingrid = {
    includes = [
      den.provides.define-user
      den.provides.primary-user
      (den.provides.user-shell "fish")
    ];
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [ 
        pkgs.htop
      ];
    };
    provides.to-hosts.nixos = { pkgs, ... }: { };
  };
}