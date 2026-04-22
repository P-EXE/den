{ den, inputs, lib, ... }: {
  flake-file = {
    inputs = {
      vscode-server.url = "github:nix-community/nixos-vscode-server";
    };
  };
  den.aspects.alice._.coding = {
    includes = lib.attrValues den.aspects.alice._.coding._;
    _.editors = {
      homeManager = {
        programs.vscode.enable = true;
      };
      _.to-hosts.nixos = {
        imports = [
          inputs.vscode-server.nixosModules.default
        ];
        services.vscode-server.enable = true;
      };
    };
    _.tools = {
      homeManager = {
        programs.git.enable = true;
      };
    };
  };
}