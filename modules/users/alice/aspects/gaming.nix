{ den, ... }: {
	den.aspects.alice.provides.gaming = {
		homeManager = { pkgs, ... }: {
			home.packages = with pkgs; [
				steam
			];
		};
	};
}
