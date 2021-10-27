# Run with `nix-shell`

# you can use <nixpkgs> too
{ pkgs ? import <nixos> {}, unstable_pkgs ? import <nixos-unstable> {} }:

with unstable_pkgs; let
  my_raylib = raylib.overrideAttrs ( old: rec  {
    # Not really, but needed to run preFixup
    version = "3.7.0";

    src = fetchGit {
      url = "https://github.com/raysan5/raylib";
      rev = "65076464d536ceb2e3f5475f3637ac0f0e67a7d6";
      ref = "master";
    };

    nativeBuildInputs = [ cmake ];
    buildInputs = [
      mesa libGLU glfw xorg.libX11 xorg.libXi xorg.libXcursor xorg.libXrandr xorg.libXinerama alsa-lib libpulseaudio
    ];

    preFixup = ''
    ${"patchelf --add-needed ${alsa-lib}/lib/libasound.so $out/lib/libraylib.so.${version}"}
    ${"patchelf --add-needed ${libpulseaudio}/lib/libpulse.so $out/lib/libraylib.so.${version}"}
    '';

    patches = [];
  });

in pkgs.mkShell {
    # nativeBuildInputs is usually what you want -- tools you need to run
    nativeBuildInputs = [
      # To Compile
      my_raylib 
      unstable_pkgs.buildPackages.glibc
      unstable_pkgs.buildPackages.binutils
      unstable_pkgs.buildPackages.pkg-config
      unstable_pkgs.buildPackages.clang-tools
      # clang-format
      unstable_pkgs.buildPackages.clang_12
    ];
}
