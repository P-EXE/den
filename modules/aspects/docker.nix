{
  den.aspects.virtualization._.docker = { host, user }: {
		nixos = { config, lib }: {
			virtualisation.docker = {
  			enable = true;
			};
			users.users.${user.userName}.extraGroups =
      	(lib.optional config.virtualisation.docker.enable "docker");
    };
	};
}