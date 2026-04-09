# defines all hosts + users + homes.
# then config their aspects in as many files you want
{
  # Linux Hosts
  den.hosts.x86_64-linux.framework13.users.alice = { };

  # Darwin Hosts
  den.hosts.x86_64-darwin.macbookpro.users.alice = { };

  # Standalone Home Manager
  den.homes.x86_64-linux.alice = { };

  # other hosts can also have user alice.
  den.hosts.x86_64-linux.south = {
    wsl = { }; # add nixos-wsl input for this.
    users.alice = { };
  };
}
