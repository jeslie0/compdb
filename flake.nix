{
  description = "A flake providing compdb, the compilation database swiss army knife.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        pythonPkgs = pkgs.python3Packages;
      in
        {
          packages.default = pythonPkgs.buildPythonPackage {
            pname = "compdb";
            version = "0.2.0";
            src = pkgs.fetchFromGitHub {
              owner = "Sarcasm";
              repo = "compdb";
              rev = "v0.2.0";
              sha256 = "sha256-nFAgTrup6V5oE+LP4UWDOCgTVCv2v9HbQbkGW+oDnTg=";
            };
            propogatedBuildInputs = with pythonPkgs; [ configparser ];
            meta = {
              description = "The compilation database Swiss army knife.";
              homepage = "https://github.com/Sarcasm/compdb";
            };
          };
        }
    );
}
