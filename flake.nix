{
  inputs = {
    nixpkgs_stable.url = "github:NixOS/nixpkgs/nixos-22.05";
    nixpkgs_unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils/v1.0.0";
  };

  outputs = { self, nixpkgs_stable, nixpkgs_unstable, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs_stable { system = system; };
        pkgs_unstable = import nixpkgs_unstable { system = system; };
      in
      {
        devShell = pkgs.mkShell {
          nativeBuildInputs = with pkgs_unstable; [
            elixir
            erlang
            pkg-config
            raylib
            glibc
            clang-tools
          ];
          packages = with pkgs; [
            gnumake
          ];
          shellHook = ''
            export CPATH="$(erl -eval 'io:format("~s", [lists:concat([code:root_dir(), "/erts-", erlang:system_info(version), "/include"])])' -s init stop -noshell):`pwd`/deps/unifex/c_src/unifex/nif"
          '';
        };
      }
    );
}
