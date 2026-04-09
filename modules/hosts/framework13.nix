{
  # host aspect
  den.aspects.framework13 = {
    # host NixOS configuration
    nixos = { pkgs, ... }: {
      environment.systemPackages = [ pkgs.hello ];
    };

    # host provides default home environment for its users
    _.to-users.homeManager = { pkgs, ... }: {
      home.packages = [ pkgs.vim ];
    };
  };
}
