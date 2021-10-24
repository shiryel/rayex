# Run with `nix-shell`

{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
    # nativeBuildInputs is usually what you want -- tools you need to run
    nativeBuildInputs = [ 
      pkgs.buildPackages.pkg-config
      pkgs.buildPackages.raylib 
      pkgs.buildPackages.clang-tools
    ];
}
