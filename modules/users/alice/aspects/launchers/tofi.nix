{ den, ... } : {
  den.aspects.alice._.launchers._.tofi = {
    homeManager = { ... } : {
      programs.tofi = {
        enable = true;
      };
    };
  };
}