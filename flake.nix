{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      systems = wrapper: builtins.mapAttrs
        (system: pkgs: wrapper (import nixpkgs { inherit system; }))
        nixpkgs.legacyPackages;
    in
    {
      devShell = systems (pkgs: pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          elixir_1_17
          erlang
          gnumake
          pkg-config
          clang-tools
        ];
        buildInputs = with pkgs; [
          raylib
        ];
        shellHook = ''
          export CPATH="$(erl -eval 'io:format("~s", [lists:concat([code:root_dir(), "/erts-", erlang:system_info(version), "/include"])])' -s init stop -noshell):`pwd`/deps/unifex/c_src/unifex/nif"
        '';
      });
    };
}
