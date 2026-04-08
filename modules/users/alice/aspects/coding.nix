{ den, ... }: {
	flake-file.inputs = {
		alejandra = {
			url = "github:kamadorueda/alejandra/4.0.0";
    	inputs.nixpkgs.follows = "nixpkgs";
		};
  };
	den.aspects.alice._.coding = {
#		nixos = { inputs, system, ... }: {
#			environment.systemPackages = [inputs.alejandra.defaultPackage.${system}];
#		};
		homeManager = {
			programs = {
				vscode = {
  	    	enable = true;
      	};
				git = {
					enable = true;
				};
			};
		};
	};
}
