{
  description = "sheetstorm - a typst template for university exercise sheets";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        devShells.default = pkgs.mkShell {
          name = "sheetstorm";
          packages = with pkgs; [
            typst
            tinymist
          ];
        };
      }
    );
}
