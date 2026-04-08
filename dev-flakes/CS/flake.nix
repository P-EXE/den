{
  description = "C# dev flake template";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };
  outputs = inputs @ {self, ...}: inputs.flake-parts.lib.mkFlake {inherit inputs;} {
    systems = [
      "aarch64-darwin"
      "x86_64-darwin"
      "x86_64-linux"
    ];
    perSystem = {pkgs, ...}: {
      devShells = {
        default = let 
          dotnetSdk = pkgs.dotnetCorePackages.sdk_10_0;
        in pkgs.mkShell {
          nativeBuildInputs = [
            dotnetSdk
          ];
          DOTNET_BIN = "${dotnetSdk}/bin/dotnet";
        };
      };
    };
  };
}