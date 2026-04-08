# defines all hosts + users + homes.
# then config their aspects in as many files you want
{
  flake-file.inputs = {
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };
  
  den.hosts.x86_64-linux.framework13.users.alice = { };
  den.hosts.x86_64-linux.blackbox.users.alice = { };

  # define an standalone home-manager for tux
  # den.homes.x86_64-linux.tux = { };

  # be sure to add nix-darwin input for this:
  # den.hosts.aarch64-darwin.apple.users.alice = { };

  # other hosts can also have user tux.
  # den.hosts.x86_64-linux.south = {
  #   wsl = { }; # add nixos-wsl input for this.
  #   users.tux = { };
  #   users.orca = { };
  # };
}
