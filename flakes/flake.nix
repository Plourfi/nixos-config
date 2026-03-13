{
  description = "A Nix flake for IDA Pro with libGL, GTK, and Qt/XCB support";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        system = system;
        config.allowUnfree = true;  # IDA Pro is proprietary software
      };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
              cairo
              dbus
              fontconfig
              freetype
              glib
              gtk3
              libdrm
              libGL
              libkrb5
              libsecret
              libunwind
              libxkbcommon
              openssl
              stdenv.cc.cc
              xorg.libICE
              xorg.libSM
              xorg.libX11
              xorg.libXau
              xorg.libxcb
              xorg.libXext
              xorg.libXi
              xorg.libXrender
              xorg.xcbutilimage
              xorg.xcbutilkeysyms
              xorg.xcbutilrenderutil
              xorg.xcbutilwm
              zlib
        ];

        shellHook = ''
          export LD_LIBRARY_PATH=`pwd`:${pkgs.lib.makeLibraryPath [
              pkgs.cairo
              pkgs.dbus
              pkgs.fontconfig
              pkgs.freetype
              pkgs.glib
              pkgs.gtk3
              pkgs.libdrm
              pkgs.libGL
              pkgs.libkrb5
              pkgs.libsecret
              pkgs.libunwind
              pkgs.libxkbcommon
              pkgs.openssl
              pkgs.stdenv.cc.cc
              pkgs.xorg.libICE
              pkgs.xorg.libSM
              pkgs.xorg.libX11
              pkgs.xorg.libXau
              pkgs.xorg.libxcb
              pkgs.xorg.libXext
              pkgs.xorg.libXi
              pkgs.xorg.libXrender
              pkgs.xorg.xcbutilimage
              pkgs.xorg.xcbutilkeysyms
              pkgs.xorg.xcbutilrenderutil
              pkgs.xorg.xcbutilwm
              pkgs.zlib
          ]}:$LD_LIBRARY_PATH
          export QT_PLUGIN_PATH=`pwd`/plugins
          export QT_QPA_PLATFORM_PLUGIN_PATH=`pwd`/plugins/platforms
          echo "Environment for IDA Pro is ready. You can now run ida64."
        '';
      };
    };
}

