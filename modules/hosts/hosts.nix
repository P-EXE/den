# defines all hosts + users + homes.
# then config their aspects in as many files you want
{
  # Linux Hosts
  den.hosts.x86_64-linux.framework13 = {
    users = {
      alice = { };
    };
    hwInfo = {
      deviceType = "laptop";
      displays = [{
        name = "eDP-1";
        resolution.x = 2880;
        resolution.y = 1920;
        refreshRate = 60.0;
        orientation = 0;
        offset.x = 0;
        offset.y = 0;
        scale = 1.0;
        pseudoScale = 1.4;
        safezones.top-left = {x = 24; y = 24;};
        safezones.top-right = {x = 24; y = 24;};
      }];
      keyboards = [
        { layout = "us"; }
      ];
    };
  };
  den.hosts.x86_64-linux.blackbox.users = {
    alice = { };
    ingrid = { };
  };

  # Darwin Hosts
  den.hosts.x86_64-darwin.macbookpro.users = {
    alice = { };
  };

  # Standalone Home Manager
  den.homes.x86_64-linux.alice = { };

  # other hosts can also have user alice.
  den.hosts.x86_64-linux.south = {
    wsl = { }; # add nixos-wsl input for this.
    users.alice = { };
  };
}
