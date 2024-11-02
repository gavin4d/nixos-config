{
  description = "CodeComposerStudio";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = {self, nixpkgs}: {
    packages.x86_64-linux= {
      CodeComposerStudio =
        with import nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
          config.permittedInsecurePackages = [
                  "python-2.7.18.7"
                ];
          config.packageOverrides = pkgs: {
            steam = pkgs.steam.override {
              extraPkgs = pkgs: with pkgs; [
                libxcrypt-legacy
                python2
                ncurses5
                libusb-compat-0_1
              ];
            };
          };

        };

      stdenv.mkDerivation rec {
        name = "CodeComposerStudio-${version}";
        version = "12.6.0";
        build = "00008";
        src = pkgs.fetchurl {
          url = "https://dr-download.ti.com/software-development/ide-configuration-compiler-or-debugger/MD-J1VdearkvK/${version}/CCS${version}.${build}_linux-x64.tar.gz";
          sha256 = "sha256-UBzThgBSy5oJfIZGE5RgMlVkCNh/16jtoYF/J0INBOc=";
        };

        desktopItem = makeDesktopItem {
          type = "Application";
          terminal = false;
          name = "Code Composer Studio";
          exec = "ccs";
          icon = "ccs";
          comment = "Texas Instruments Code Composer Studio";
          desktopName = "Code Composer Studio";
          genericName = "Code Composer Studio";
          categories = [ "Development" ];
        };


        buildInputs = [
            openssl
            zlib
            glib
            jdk
            unzip
            steam-run
       ];

        sourceRoot = ".";
        installPhase = ''
          runHook preInstall
          steam-run ./CCS${version}.${build}_linux-x64/ccs_setup_${version}.${build}.run --mode unattended --enable-components PF_MSP430 --prefix /build/ti/
          # compile the libraries for your target arch
          # PATH=/build/ti/ccs/tools/compiler/ti-cgt-arm_20.2.7.LTS/bin:$PATH steam-run /build/ti/ccs/tools/compiler/ti-cgt-arm_20.2.7.LTS/lib/mklib --pattern TI-RTOS.lib
          PATH=/build/ti/ccs/tools/compiler/ti_cgt_armllvm_4.0.0.LTS/bin:$PATH steam-run /build/ti/ccs/tools/compiler/ti_cgt_armllvm_4.0.0.LTS/lib/mklib --pattern TI-RTOS.lib
          echo $out
          mv /build/ti $out


          mkdir -p $out/share/icons
          ln -s $out/ccs/doc/ccs.ico $out/share/icons/ccs.ico

          mkdir -p $out/share/applications
          cp ${desktopItem}/share/applications/* $out/share/applications

          mkdir -p $out/bin
          echo "#! /usr/bin/env bash" > $out/bin/ccs
          echo "steam-run $out/ccs/eclipse/ccstudio" >> $out/bin/ccs
          chmod oug+x $out/bin/ccs

          '';

        meta = with lib; {
          homepage = "https://ti.org";
          description = "CodeComposerStudio";
          platforms = platforms.linux;
        };
      };
      default = self.packages.x86_64-linux.CodeComposerStudio;
    };
  };
}
