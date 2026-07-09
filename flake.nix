{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        # nixpkgs-stable.follows = "nixpkgs";
      };
    };
        
    ags.url = "github:Aylur/ags/a6a7a0adb17740f4c34a59902701870d46fbb6a4";
    waveforms.url = "github:liff/waveforms-flake/01cf86d6f945f12800d252d4c040f16670de5962";
    catppuccin.url = "github:catppuccin/nix";
    CCStudio.url = "path:/etc/nixos/modules/home-manager/programs/CCStudio";
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { home-manager, self, nixpkgs, nixpkgs-stable, waveforms, catppuccin, nix-colors,  ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      # pkgs-stable = import nixpkgs-stable {
      #   system = "x86_64-linux";
      #   config = {
      #     allowUnfree = true;
      #     allowUnfreePredicate = _: true;
      #   };
      #   # legacyPackages.${system};
      # };
      allowed-unfree-packages = [
        "steam"
      ];
    in
    {
    
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          # inherit pkgs-stable;
          inherit allowed-unfree-packages;
        };
        # module.args = { inherit CCStudio;};
        modules = [ 
          ./configuration.nix 
      	  ./system
          home-manager.nixosModules.home-manager
            # {
            #   home-manager.useGlobalPkgs = true;
            #   home-manager.useUserPackages = true;
            #   home-manager.users.jdoe = ./home.nix;

            #   # Optionally, use home-manager.extraSpecialArgs to pass
            #   # arguments to home.nix
            # }
          # home-manager.nixosModules
      	  waveforms.nixosModule
          # CCStudio
          ({ users.users.gavin4d.extraGroups = [ "plugdev" ]; })
        ];
      };

      homeConfigurations.gavin4d = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { inherit system;
        };

        # pass inputs as specialArgs
        extraSpecialArgs = {
          inherit inputs;
          # inherit pkgs-stable;
          inherit allowed-unfree-packages;
          inherit nix-colors;
        };

        # import your home.nix
        modules = [ 
      	  ./modules/home-manager/home.nix
      	  #catppuccin.homeManagerModules.catppuccin
      	];
      };
    };
}
