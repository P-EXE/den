{ den, ... }: {
  den.aspects.alice = {
    includes = [
      den.provides.define-user
      den.provides.primary-user
      (den.provides.user-shell "fish")
      den.aspects.alice._.coding
      den.aspects.alice._.gaming
    ];

    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [ 
      	htop
        vesktop
      ];
      
      programs.firefox = {
        enable = true;
      };
    };

    # user can provide NixOS configurations
    # to any host it is included on
    provides.to-hosts.nixos = { pkgs, ... }: { };
  };
}
