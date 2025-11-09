{
  description = "sheetstorm - a typst template for university exercise sheets";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    tytanic = {
      url = "github:typst-community/tytanic/v0.3.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, tytanic, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        devShells.default = pkgs.mkShell {
          name = "sheetstorm";
          packages = with pkgs; [
            typst
            tinymist
            typstyle
            tytanic.outputs.packages.${system}.default
            just
          ];
        };
      }
    );
}
